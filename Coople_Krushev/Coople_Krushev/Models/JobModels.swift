//
//  JobResponse.swift
//  Coople_test
//
//  Created by Krushev on 8/5/23.
//

import Foundation

struct JobResponse: Codable {
    let status: Int?
    let data: JobData?
    let errorCode: String?
    let error: Bool?
}

struct JobData: Codable {
    let items: [Job]?
    let total: Int?
}

struct Job: Codable {
    let workAssignmentId: String?
    let waReadableId: String?
    let hourlyWage: HourlyWage?
    let salary: Salary?
    let jobSkill: JobSkill?
    let workAssignmentName: String?
    let jobLocation: JobLocation?
    let periodFrom: Int64?
    let datePublished: Int64?
    let branchLink: String?
}

struct HourlyWage: Codable {
    let amount: Double?
    let currencyId: Int?
}

struct Salary: Codable {
    let amount: Double?
    let currencyId: Int?
}

struct JobSkill: Codable {
    let jobProfileId: Int?
    let educationalLevelId: Int?
}

struct JobLocation: Codable {
    let addressStreet: String?
    let extraAddress: String?
    let zip: String?
    let city: String?
    let state: String?
    let countryId: Int?
}
