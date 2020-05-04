//
//  YPWordings.swift
//  YPImagePicker
//
//  Created by Sacha DSO on 12/03/2018.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import Foundation

public struct YPWordings {
    
    public var permissionPopup = PermissionPopup()
    public var videoDurationPopup = VideoDurationPopup()

    public struct PermissionPopup {
//        public var title = ypLocalized("YPImagePickerPermissionDeniedPopupTitle")
//        public var message = ypLocalized("YPImagePickerPermissionDeniedPopupMessage")
//        public var cancel = ypLocalized("YPImagePickerPermissionDeniedPopupCancel")
//        public var grantPermission = ypLocalized("YPImagePickerPermissionDeniedPopupGrantPermission")
        public var title = "액세스가 거부되었습니다."
        public var message = "권한을 부여하세요."
        public var cancel = "허용 안 함"
        public var grantPermission = "허용"
    }
    
    public struct VideoDurationPopup {
//        public var title = ypLocalized("YPImagePickerVideoDurationTitle")
//        public var tooShortMessage = ypLocalized("YPImagePickerVideoTooShort")
//        public var tooLongMessage = ypLocalized("YPImagePickerVideoTooLong")
        public var title = "동영상 길이"
        public var tooShortMessage = "동영상 최소 시간을 채워주세요."
        public var tooLongMessage = "동영상 최대 시간을 벗어났습니다."
    }
    
//    public var ok = ypLocalized("YPImagePickerOk")
//    public var done = ypLocalized("YPImagePickerDone")
//    public var cancel = ypLocalized("YPImagePickerCancel")
//    public var save = ypLocalized("YPImagePickerSave")
//    public var processing = ypLocalized("YPImagePickerProcessing")
//    public var trim = ypLocalized("YPImagePickerTrim")
//    public var cover = ypLocalized("YPImagePickerCover")
//    public var albumsTitle = ypLocalized("YPImagePickerAlbums")
//    public var libraryTitle = ypLocalized("YPImagePickerLibrary")
//    public var cameraTitle = ypLocalized("YPImagePickerPhoto")
//    public var videoTitle = ypLocalized("YPImagePickerVideo")
//    public var next = ypLocalized("YPImagePickerNext")
//    public var filter = ypLocalized("YPImagePickerFilter")
//    public var crop = ypLocalized("YPImagePickerCrop")
//    public var warningMaxItemsLimit = ypLocalized("YPImagePickerWarningItemsLimit")
    public var ok = "확인"
    public var done = "완료"
    public var cancel = "취소"
    public var save = "저장"
    public var processing = "처리중..."
    public var trim = "자르기"
    public var cover = "커버"
    public var albumsTitle = "앨범"
    public var libraryTitle = "라이브러리"
    public var cameraTitle = "사진"
    public var videoTitle = "비디오"
    public var next = "다음"
    public var filter = "필터"
    public var crop = "자르기"
    public var warningMaxItemsLimit = "사진과 동영상의 최대 선택갯수를 벗어났습니다."
}
