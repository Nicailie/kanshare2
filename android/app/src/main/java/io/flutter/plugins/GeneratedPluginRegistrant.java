package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.camerax.CameraAndroidCameraxPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin camera_android_camerax, io.flutter.plugins.camerax.CameraAndroidCameraxPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.firestore.FlutterFirebaseFirestorePlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin cloud_firestore, io.flutter.plugins.firebase.firestore.FlutterFirebaseFirestorePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin firebase_auth, io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin firebase_core, io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.database.FirebaseDatabasePlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin firebase_database, io.flutter.plugins.firebase.database.FirebaseDatabasePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.storage.FlutterFirebaseStoragePlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin firebase_storage, io.flutter.plugins.firebase.storage.FlutterFirebaseStoragePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.fluttercandies.flutter_image_compress.ImageCompressPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin flutter_image_compress_common, com.fluttercandies.flutter_image_compress.ImageCompressPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin flutter_plugin_android_lifecycle, io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin fluttertoast, io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_barcode_scanning.GoogleMlKitBarcodeScanningPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_barcode_scanning, com.google_mlkit_barcode_scanning.GoogleMlKitBarcodeScanningPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_commons.GoogleMlKitCommonsPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_commons, com.google_mlkit_commons.GoogleMlKitCommonsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_digital_ink_recognition.GoogleMlKitDigitalInkRecognitionPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_digital_ink_recognition, com.google_mlkit_digital_ink_recognition.GoogleMlKitDigitalInkRecognitionPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_entity_extraction.GoogleMlKitEntityExtractionPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_entity_extraction, com.google_mlkit_entity_extraction.GoogleMlKitEntityExtractionPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_face_detection.GoogleMlKitFaceDetectionPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_face_detection, com.google_mlkit_face_detection.GoogleMlKitFaceDetectionPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_face_mesh_detection.GoogleMlKitFaceMeshDetectionPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_face_mesh_detection, com.google_mlkit_face_mesh_detection.GoogleMlKitFaceMeshDetectionPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_image_labeling.GoogleMlKitImageLabelingPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_image_labeling, com.google_mlkit_image_labeling.GoogleMlKitImageLabelingPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_language_id.GoogleMlKitLanguageIdPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_language_id, com.google_mlkit_language_id.GoogleMlKitLanguageIdPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_object_detection.GoogleMlKitObjectDetectionPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_object_detection, com.google_mlkit_object_detection.GoogleMlKitObjectDetectionPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_pose_detection.GoogleMlKitPoseDetectionPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_pose_detection, com.google_mlkit_pose_detection.GoogleMlKitPoseDetectionPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_selfie_segmentation.GoogleMlKitSelfieSegmentationPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_selfie_segmentation, com.google_mlkit_selfie_segmentation.GoogleMlKitSelfieSegmentationPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_smart_reply.GoogleMlKitSmartReplyPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_smart_reply, com.google_mlkit_smart_reply.GoogleMlKitSmartReplyPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_text_recognition.GoogleMlKitTextRecognitionPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_text_recognition, com.google_mlkit_text_recognition.GoogleMlKitTextRecognitionPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.google_mlkit_translation.GoogleMlKitTranslationPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_mlkit_translation, com.google_mlkit_translation.GoogleMlKitTranslationPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.googlesignin.GoogleSignInPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin google_sign_in_android, io.flutter.plugins.googlesignin.GoogleSignInPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.imagepicker.ImagePickerPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin image_picker_android, io.flutter.plugins.imagepicker.ImagePickerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin path_provider_android, io.flutter.plugins.pathprovider.PathProviderPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.share.SharePlusPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin share_plus, dev.fluttercommunity.plus.share.SharePlusPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.urllauncher.UrlLauncherPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin url_launcher_android, io.flutter.plugins.urllauncher.UrlLauncherPlugin", e);
    }
  }
}
