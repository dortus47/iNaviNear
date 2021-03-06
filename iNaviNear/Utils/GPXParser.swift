//
//  GPXParser.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import Foundation
import iNaviMaps

class GPXParser: NSObject, XMLParserDelegate {
    
    // 태그 내부의 파싱한 정보를 전달해 주기 전까지 임시로 들고있는 객체.
    var foundCharacters: String = ""
    var location: INVLatLng = INVLatLng()
    var name: String = ""
    var time: String = ""
    var ele: String = ""
    
    var CafeDataArray: [CafeData] = []
    var TrkDataArray: [TrkData] = []
    
    
    // MARK: Created function.
    
    func parsingLakeLocationGPX(filepath: URL) -> [TrkData]? {
        
        let parser = XMLParser(contentsOf: filepath)!
        parser.delegate = self
        let success = parser.parse()
        if success {
            
            print("gpx file parsing is done.")
            return TrkDataArray
        }
        else {
            
            print(parser.parserError.debugDescription)
        }
        return nil
    }
    
    func parsingCafeLocationGPX(filepath: URL) -> [CafeData]? {
        
        let parser = XMLParser(contentsOf: filepath)!
        parser.delegate = self
        let success = parser.parse()
        if success {
            
            print("gpx file parsing is done.")
            return CafeDataArray
        }
        else {
            
            print(parser.parserError.debugDescription)
        }
        return nil
    }
    
    // MARK: XMLParserDelegate function.
    
    
    // XML 파싱을 시작하는 태그에서 이벤트 핸들링
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        foundCharacters = ""
        
        // ex: CafeLocation.gpx
        if elementName == "wpt" {
            
            guard let lat = attributeDict["lat"],
                  let lon = attributeDict["lon"] else {
                return
            }
            
            location = INVLatLng(lat: Double(lat)!, lng: Double(lon)!)
        }
        // ex: BaegUnLake.gpx
        else if elementName == "trkpt" {
            
            guard let lat = attributeDict["lat"],
                  let lon = attributeDict["lon"] else {
                return
            }
            
            location = INVLatLng(lat: Double(lat)!, lng: Double(lon)!)
        }
    }
    
    // 태그의 Data가 string으로 들어옴
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        foundCharacters += string // name, time, ele ...
    }
    
    // XML 파싱이 끝나는 태그에서 이벤트 핸들링
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "name" {
            name = foundCharacters
        } else if elementName == "time" {
            time = foundCharacters
        } else if elementName == "ele" {
            ele = foundCharacters
        } else if elementName == "wpt" {
            var cafeData = CafeData()
            cafeData.name = name
            cafeData.location = location
            cafeData.star = String( Int.random(in: 1...5) )
            CafeDataArray.append(cafeData)
        } else if elementName == "trkpt" {
            var trkData = TrkData()
            trkData.ele = ele
            trkData.time = time
            trkData.location = location
            TrkDataArray.append(trkData)
        }
        
        foundCharacters = ""
    }
}
