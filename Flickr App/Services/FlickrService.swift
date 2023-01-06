//
//  FlickrService.swift
//  Flickr App
//
//  Created by Raj Kumar on 06/01/23.
//

import Foundation
import Alamofire

struct FlickrService {
    
    static let shared = FlickrService()
    
    func requestFetchPhoto(completion: @escaping (FlickrModel?, Error?) -> ()) {
        let url = Constants.FlickrAPI.GET_LIST_API
        Alamofire.request(url).responseFlickrImage { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let flickList = response.result.value {
                completion(flickList, nil)
                return
            }
        }
    }
    
}

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseFlickrImage(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<FlickrModel>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
