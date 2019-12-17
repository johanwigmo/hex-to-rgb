//
//  main.swift
//  hex-to-rgb
//
//  Created by Johan Wigmo on 2019-12-17.
//  Copyright © 2019 Wigmo Productions. All rights reserved.
//

import Foundation

func validate(input: [String]) -> String {
    guard input.count > 1 else {
        print("No arguments")
        exit(EXIT_FAILURE)
    }
    
    guard input[1].count == 8 && input[1].prefix(2) == "-#" else {
        print("Input should be formatted like '#RRGGBB'")
        exit(EXIT_FAILURE)
    }

    for char in input[1].suffix(6) {
        if !char.isHexDigit {
            print("Input is not a valid hex (0-F)")
            exit(EXIT_FAILURE)
        }
    }
    
    return String(input[1].suffix(6))
}

func convert(hex: String) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
    guard let value = UInt(hex, radix: 16) else {
        print("Could not convert hex")
        exit(EXIT_FAILURE)
    }
    
    let red = CGFloat((value & 0xFF0000) >> 16)
    let green = CGFloat((value & 0x00FF00) >> 8)
    let blue = CGFloat(value & 0x0000FF)

    return (red, green, blue)
}

let validInput = validate(input: CommandLine.arguments)
let hex = convert(hex: validInput)
print(hex)

exit(EXIT_SUCCESS)
