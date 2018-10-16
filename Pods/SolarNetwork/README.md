# ![SLNetwork](SLNetwork.png)

![Build Status](https://travis-ci.org/Alamofire/Alamofire.svg?branch=master) ![CocoaPods Compatible](https://img.shields.io/cocoapods/v/SolarNetwork.svg) ![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)  ![Platform](https://img.shields.io/cocoapods/p/SolarNetwork.svg?style=flat)

Elegant network abstraction layer in Swift.



- [中文](ChineseREADME.md)
- [Design](#design)
- [Features](#features)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Usage](#usage)
  - [Base Usage](#base-usage) - [Target](#target) - [Request](#request) - [Download](#download) - [Upload](#upload) - [Decode](#decode)
  - [Target](Documentation/Target.md) - Configuration of a Host.
  - [Request](Documentation/Request.md) - Configuration of a DataRequest.
  - [Download](Documentation/Download.md) - Configuration of a DownloadRequest or ResumeDownloadRequest.
  - [Upload](Documentation/Upload.md) - Configuration of a UploadRequest(Data - File - InputStream - FormData).
  - [Progress](Documentation/Progress.md) - Progress
  - [Response](Documentation/Response.md) - Decode - Error
  - [Plugin](Documentation/Plugin.md) - WillSend - DidReceive
- [License](#license)

---

# Design

**Alamofire** and **Moya** are elegant Swift network frames. They each have their own advantages. When I use them, I always want to combine the advantages of both, make them easy to use and retain their original features. So I wrote the **SolarNetwork**.

- **SLNetwork** corresponds to a SessionManager.
- **SLTarget** corresponds to a Host, or a set of requests for the same configuration.
- **SLRequest**, **SLDownloadRequest**, **SLUploadRequest** corresponds to Request of Data, Download, Upload.
- **SLProgress** return progress when download or upload.
- **SLResponse** response of a request which you can decode to JsonObject or Model.
- **SLPlugin** you can modify SLRequest in `willSend` and modify SLResponse in `didReceive`.
- **SLReflection** reflex properties of SubSLRequest to Alamofire.Parameters.

So a complete request process is:

```swift
SLNetwork(SLTarget).request(SLRequest).willSend(SLRequest)
                   .progressClosure(SLProgress)
                   .reponseData(OriginalResponse)
                   .didReceive(SLResponse).decodeTo(Dictionary)
                   .completionClosure(SLResponse)
                   .decodeTo(Model: Decodable).dealWithError
```

In most cases, what you need to concerned about is:

```swift
SLNetwork(SLTarget).request(SLRequest)
                   .progressClosure(SLProgress)
                   .completionClosure(SLResponse)
```

---

# Features

- [x] URL / JSON / plist Parameter Encoding
- [x] Upload File / Data / Stream / MultipartFormData
- [x] Download File using Request or Resume Data
- [x] Authentication with URLCredential
- [x] Upload and Download Progress Closures with Progress
- [x] Dynamically Adapt and Retry Requests
- [x] TLS Certificate and Public Key Pinning
- [x] Network Reachability
- [x] Pre-populate the DNS cache
- [x] Complete Logger

---

## Requirements

- iOS 8.0+
- Xcode 9+
- Swift 4+

---

## Communication

- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/alamofire).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

---

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1+ is required.

To integrate SolarNetwork into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SolarNetwork'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Alamofire into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "ThreeGayHub/SolarNetwork"
```

Run `carthage update` 

If this is your first time using Carthage in the project, you'll need to go through some additional steps as explained [over at Carthage](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

---

# Usage

## Base Usage

### Target

```swift
import SolarNetwork

struct HTTPBinTarget: SLTarget {
    var baseURLString: String { return "https://httpbin.org" }
}

let HTTPBinNetwork = SLNetwork(HTTPBinTarget())
```

### Request

```swift
import SolarNetwork

//Mark: - GET
class HTTPBinGETRequest: SLRequest {
    
    override func loadRequest() {
        super.loadRequest()
        
        self.path = "/get"
    }
    
}

HTTPBinNetwork.request(HTTPBinGETRequest()) { (response) in
    if let dictionary = response.dataDictionary {
                        
    }
    else if let error = response.error {
        //show error
    }
}

//Mark: - POST
class HTTPBinPOSTRequest: SLRequest {
    
    override func loadRequest() {
        super.loadRequest()
        
        self.method = .post
        self.path = "/post"
    }
    
    /**
     properties will encode to parameters by Reflection
     ["userName": "myUserName",
      "password": "myPassword",
	  "name" : "youName"]
     */
    let userName = "myUserName"
    let password = "myPassword"
	
    var name: String?
}

let postReq = HTTPBinPOSTRequest()
postReq.name = "yourName"
HTTPBinNetwork.request(postReq) { (response) in
    if let dictionary = response.dataDictionary {
                        
    }
    else if let error = response.error {
        //show error
    }
}
```

### Download

```swift
import SolarNetwork

class HTTPBinDownLoadRequest: SLDownloadRequest {
    
    override func loadRequest() {
        super.loadRequest()
        
        self.path = "/image/png"
        self.isResume = true //control the download request is resume or not, default is false
    }
}

HTTPBinNetwork.download(HTTPBinDownLoadRequest(), progressClosure: { (progress) in
                    
}) { (resposne) in
                    
}

```

### Upload

```swift
import SolarNetwork

class HTTPBinUploadRequest: SLUploadRequest {
    
    override func loadRequest() {
        super.loadRequest()
        
        self.path = "/post"
    }
    
}

let uploadRequest = HTTPBinUploadRequest()
uploadRequest.data = data //data to upload
HTTPBinNetwork.upload(uploadRequest, progressClosure: { (progress) in
                            
}) { (response) in
                            
}
```

### Decode

In Swift 4, you can use Codable.

```swift
import SolarNetwork

struct User: Decodable { //Swift 4 Codable
    var id: Int
    var name: String
    var token: String
}

HTTPBinNetwork.request(UserRequest()) { (response) in
    if let user = response.decode(to: User.self) {
                        
    }
    else if let error = response.error {
        //show error
    }
}
```



---

## License

Alamofire is released under the MIT license. [See LICENSE](https://github.com/ThreeGayHub/SolarNetwork/blob/master/LICENSE) for details.

