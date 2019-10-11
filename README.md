# Survey Monkey iOS SDK Retain Cycle
The latest Survey Monkey SDK for iOS (2.0.4) contains a retain cycle where it retains the view controller that it presents itself upon.

## Build
Project is linked with CocoaPods and set up with a Gemfile so if you want to do it proper:

```sh
$ bundle install --path vendor/bundle
```

Then:

```sh
$ pod install
```

Built with Xcode 11.1.
