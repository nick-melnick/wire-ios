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

import XCTest
@testable import Wire

final class ConversationListViewControllerTests: ZMSnapshotTestCase {
    
    var sut: ConversationListViewController!
    
    override func setUp() {
        super.setUp()
        sut = ConversationListViewController()

        ///The name is Tarja Turunen, one of the mock users
        let account = Account(userName: "", userIdentifier: UUID(), teamName: nil, imageData: UIImageJPEGRepresentation(self.image(inTestBundleNamed: "unsplash_matterhorn.jpg"), 0.9))
        sut.account = account

        sut.view.backgroundColor = .black
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testForNoConversations(){
        verify(view: sut.view)
    }
}
