//
//  AhtleteDelegate.swift
//
//  This file defines a protocol for our Athlete. We need this for our user interface
//  to work right. That is, so we can pass data between our views. This delegate (protocol)
//  has methods to set the skill and the gender.
//

import Foundation

protocol AthleteDelegate {
    func setSport(sport: Sport)
    func setSkill(skill: Skill)
    func setGender(gender: Gender)
}
