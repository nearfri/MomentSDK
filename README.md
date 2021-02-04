# MomentSDK

## 프로젝트 트리
xcodegen으로 SPM과 거의 동일한 구성의 Xcode 프로젝트를 생성합니다.

```
.
├── Cartfile
├── Cartfile.resolved
├── Carthage
│   ├── Build
│   └── Checkouts
├── MomentSDK.xcworkspace   <- MomentCart와 MomentApp을 포함한 워크스페이스. carthage 배포용
├── Package.swift
├── Projects
│   ├── Carthage-XcodeGen
│   │   ├── MomentCart.xcodeproj    <- xcodegen으로 생성한 프로젝트. carthage 배포용
│   ├── MomentApp
│   │   ├── MomentApp
│   │   └── MomentApp.xcodeproj     <- 샘플앱 프로젝트
│   └── MomentSample.xcworkspace    <- SPM과 MomentApp을 포함한 워크스페이스
├── README.md
├── Sources
│   ├── Common      <- MomentCommon 타겟
│   ├── Editor      <- MomentEditor 타겟
│   └── Player      <- MomentPlayer 타겟
├── Tests
│   ├── Common
│   ├── Editor
│   └── Player
└── Tools
    ├── gen-all-xcframeworks.sh     <- xcframework 빌드 스크립트
    ├── gen-xcframework.sh
    └── run-xcodegen.sh             <- xcodegen 실행 스크립트
```

## 앱에서 XCFramework 사용 시
모듈 경로를 잡아줘야 합니다.
```
SWIFT_INCLUDE_PATHS="${SRCROOT}/MomentEditor.xcframework/Submodules/${SWIFT_PLATFORM_TARGET_PREFIX}-${ARCHS_STANDARD}${LLVM_TARGET_TRIPLE_SUFFIX}"
```