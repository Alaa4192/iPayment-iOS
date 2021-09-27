//
//  BaseView.swift
//  iPayment
//
//  Created by Alaa Khoury on 27/09/2021.
//  Copyright © 2021 Alaa Khoury. All rights reserved.
//

import SwiftUI

protocol BaseView: View {

    associatedtype VM: BaseViewModel

    var viewModel: Self.VM { get }
}
