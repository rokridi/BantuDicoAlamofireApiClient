# BantuDicoAlamofireApiClient

## Features

* Translate a word using Bantu Dico API.
* Fetch languages that are supported by Bantu Dico API.

## Requirements

* iOS 11.0+
* XCode 9+
* Swift 4.0+

## Installation
### CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

```
$ gem install cocoapods
```

To integrate BantuDicoAlamofireApiClient into your Xcode project using CocoaPods, specify it in your ```Podfile```:

```
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'BantuDicoAlamofireApiClient', :git=> 'https://github.com/rokridi/BantuDicoAlamofireApiClient.git'
end
```
Then, run the following command:
```
$ pod install
```

## Usage

### Translate word

```
let client = BantuDicoAlamofireApiClient(configuration: URLSessionConfiguration.default, baseURL: "http://www.domain.com")
        
let task = client.translate(word: "hello", sourceLanguage: "en", destinationLanguage: "fr") { translation, error in
            
}
```

### Fetch supported languages

```
let client = BantuDicoAlamofireApiClient(configuration: URLSessionConfiguration.default, baseURL: "http://www.domain.com")
        
let task = client.fetchSupportedLanguages(queue: DispatchQueue.main) { languages, error in
            
}
```

