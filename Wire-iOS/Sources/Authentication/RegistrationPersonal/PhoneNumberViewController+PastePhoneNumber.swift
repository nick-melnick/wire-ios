//
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation

extension PhoneNumberViewController {
    @objc
    @discardableResult
    func pastePhoneNumber(_ phoneNumber: String?) -> Bool {
        guard let phoneNumber = phoneNumber else { return false }

        return phoneNumber.shouldPasteAsPhoneNumber(presetCountry: country){ country, phoneNumber in
            if let country = country, let phoneNumber = phoneNumber {
                self.country = country

                self.phoneNumberField.text = phoneNumber;
                self.updateRightAccessory(forPhoneNumber: phoneNumber)
            }
        }
    }
}

extension PhoneNumberViewController: RegistrationTextFieldDelegate {
    public func textField(_ textField: UITextField?, shouldPasteCharactersIn range: NSRange, replacementString string: String?) -> Bool {
        return pastePhoneNumber(string)
    }

    @objc(textField:shouldChangeCharactersInRange:replacementString:)
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }

        guard let country = country else { return true }

        ///If the textField is empty and a replacementString with longer than 1 char, it is likely to insert from autoFill.
        if textField.text?.count == 0 && string.count > 1 {
            return pastePhoneNumber(string)
        }


        let number = PhoneNumber(countryCode: country.e164.uintValue, numberWithoutCode: newString)

        switch number.validate() {
        case .containsInvalidCharacters, .tooLong:
            return false
        case .tooShort:
            break
        default:
            break
        }

        updateRightAccessory(forPhoneNumber: phoneNumber)
        return true
    }

}
