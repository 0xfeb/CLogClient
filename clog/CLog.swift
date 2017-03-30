//
//  CLog.swift
//  testCLog
//
//  Created by 王渊鸥 on 2017/3/30.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import Foundation
import Coastline

public class CLog {
	public static var shareInstance:CLog = { CLog() }()
	
	var app:String = ""
	var user:String = ""
	var device:String = DeviceId.shareInstance.udid()
	var clogUrl:String = ""
	
	public func log(title:String, content:String) {
		let sc = URLSessionConfiguration.default
		let cf = URLSession(configuration: sc)
		let jsonDict = [
			"app" :  app,
			"user" : user,
			"device" : device,
			"title": title,
			"content": content
		]
		
		if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions()), let url = clogUrl.url {
			let req = NSMutableURLRequest(url: url)
			req.setValue("application/json", forHTTPHeaderField: "Content-Type")
			req.httpMethod = "POST"
			req.httpBody = jsonData
			let q = cf.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
				print(err ?? "")
			})
			q.resume()
		}
	}
	
	public static func setup(app:String, url:String) {
		let clog = CLog.shareInstance
		clog.app = app
		clog.clogUrl = url
	}
	
	public static func info(_ text:String...) {
		let clog = CLog.shareInstance
		let str = text.combine("      ")
		clog.log(title: "INFO", content: str)
	}
	
	public static func warn(_ text:String...) {
		let clog = CLog.shareInstance
		let str = text.combine("      ")
		clog.log(title: "INFO", content: str)
	}
	
	public static func error(_ text:String...) {
		let clog = CLog.shareInstance
		let str = text.combine("      ")
		clog.log(title: "INFO", content: str)
	}
	
	public static func debug(_ text:String...) {
		let clog = CLog.shareInstance
		let str = text.combine("      ")
		clog.log(title: "INFO", content: str)
	}
}
