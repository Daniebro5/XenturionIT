/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

// swiftlint:disable multiple_closures_with_trailing_closure
struct ToolbarView: View {
  @Binding var noteLocked: Bool
  @ObservedObject var noteData: NoteData
  @Binding var setPasswordModal: Bool
  @State private var showUnlockModal: Bool = false
  @State private var changePasswordModal: Bool = false

  var body: some View {
    HStack {
      #if DEBUG
      Button(
        action: {
          print("App reset.")
          self.noteData.noteText = ""
          self.noteData.updateStoredPassword("")
        }, label: {
          Image(systemName: "trash")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 25.0, height: 25.0)
        })
      #endif

      Color.clear
        .sheet(isPresented: $setPasswordModal) {
          SetPasswordView(
            title: "Set Note Password",
            subTitle: "Enter a password to protect this note.",
            noteLocked: self.$noteLocked,
            showModal: self.$setPasswordModal,
            noteData: self.noteData
          )
        }

      Spacer()

      Button(
        action: {
          self.changePasswordModal = true
        }) {
        Image(systemName: "arrow.right.arrow.left")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 25.0, height: 25.0)
      }
      .disabled(noteLocked || noteData.isPasswordBlank)
      .sheet(isPresented: $changePasswordModal) {
        SetPasswordView(
          title: "Change Password",
          subTitle: "Enter new password",
          noteLocked: self.$noteLocked,
          showModal: self.$changePasswordModal,
          noteData: self.noteData)
      }

      Button(
        action: {
          if self.noteLocked {
            // Biometric Authentication Point
            self.showUnlockModal = true
          } else {
            self.noteLocked = true
          }
        }) {
        // Lock Icon
        Image(systemName: noteLocked ? "lock" : "lock.open")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 25.0, height: 25.0)
      }
      .sheet(isPresented: $showUnlockModal) {
        if self.noteData.isPasswordBlank {
          SetPasswordView(
            title: "Enter Password",
            subTitle: "Enter a password to protect your notes",
            noteLocked: self.$noteLocked,
            showModal: self.$changePasswordModal,
            noteData: self.noteData)
        } else {
          UnlockView(noteLocked: self.$noteLocked, showModal: self.$showUnlockModal, noteData: self.noteData)
        }
      }
    }
    .frame(height: 64)
  }
}

struct ToolbarView_Previews: PreviewProvider {
  static var previews: some View {
    ToolbarView(noteLocked: .constant(true), noteData: NoteData(), setPasswordModal: .constant(false))
  }
}
