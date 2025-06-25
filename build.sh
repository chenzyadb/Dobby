#!sh
ANDROID_NDK="d:/Apps/android-ndk"
SCRIPT_PATH=$(readlink -f "$0")
SOURCE_DIR=$(dirname "$SCRIPT_PATH")
BUILD_DIR="${SOURCE_DIR}/build"

mkdir -p "$BUILD_DIR"
cmake \
    -DCMAKE_BUILD_TYPE="release" \
    -DCMAKE_SYSTEM_NAME="Android" \
    -DCMAKE_TOOLCHAIN_FILE="${ANDROID_NDK}/build/cmake/android.toolchain.cmake" \
    -DANDROID_NATIVE_API_LEVEL=31 \
    -DANDROID_ABI="arm64-v8a" \
    -DDOBBY_GENERATE_SHARED=OFF \
    -H${SOURCE_DIR} \
    -B${BUILD_DIR} \
    -G "Ninja"
cmake --build "$BUILD_DIR" --config "release" --target "dobby" -j8

cp -f "${BUILD_DIR}/libdobby.a" "$SOURCE_DIR"
rm -rf "$BUILD_DIR"