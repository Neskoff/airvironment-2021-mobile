//
//  AlamoFireDataSource.swift
//  airviroment-2021-mobile
//
//  Created by Letnja Praksa 4 on 22.7.21..
//

import UIKit
import Alamofire


class AlamoFireDataSource: RemoteDataSource{
    func getMeasurements(meta:Meta?, result: @escaping ((Result<Response, Error>) -> Void)) {
        AF.request(Router.Measurements.getMeasurements(meta: meta), interceptor: nil).response { serverResponse in
            switch serverResponse.result {
                   case.success(_):
                       do {
                           let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .custom(JSONDecoder.dateDecodingStrategy)
                        let responseBody: Response = try jsonDecoder.decode(Response.self, from: serverResponse.data!) as Response
                        result(.success(responseBody))
                       } catch let error {
                           result(.failure(error))
                       }
                   case.failure(let error):
                       result(.failure(error))
                   }
               }
    }
    
    func getLatest(result: @escaping ((Result<Measurement, Error>) -> Void)) {
        AF.request(Router.Measurements.getLatest, interceptor: nil).response { serverResponse in
                   switch serverResponse.result {
                   case.success(_):
                       do {
                           let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .custom(JSONDecoder.dateDecodingStrategy)
                           let responseBody: Measurement = try jsonDecoder.decode(Measurement.self, from: serverResponse.data!) as Measurement
                           result(.success(responseBody))
                       } catch let error {
                           result(.failure(error))
                       }
                   case.failure(let error):
                       result(.failure(error))
                   }
               }
    }
    
    
}
