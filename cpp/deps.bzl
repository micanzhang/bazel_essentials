DEPS = {

    # NOTE(yi.sun): We have to keep a pre-historic version of GRPC (pre 1.0.1),
    # as otherwise the build will fail.
    #
    # TODO(yi.sun): There is some important bug fixes (e.g., message length,)
    # so switching to a newer version is still necessary.
    "com_github_grpc_grpc": {
        "rule": "http_archive",
        "url": "https://github.com/grpc/grpc/archive/3808b6efe66b87269d43847bc113e94e2d3d28fb.tar.gz",
        "strip_prefix": "grpc-3808b6efe66b87269d43847bc113e94e2d3d28fb",
    },

    # Hooray! The boringssl team provides a "master-with-bazel" branch
    # with all BUILD files ready to go.  To update, pick the
    # newest-ish commit-id off that branch.
    "boringssl": {
        "rule": "http_archive",
        "url": "https://boringssl.googlesource.com/boringssl/+archive/14443198abcfc48f0420011a636b220e58e18610.tar.gz", # Nov 11 2016
    },

    # libssl is required for c++ grpc where it is expected in
    # //external:libssl.  This can be either boringssl or openssl.
    "libssl": {
        "rule": "bind",
        "actual": "@boringssl//:ssl",
    },

    # C-library for zlib
    "com_github_madler_zlib": {
        "rule": "new_http_archive",
        "url": "https://github.com/madler/zlib/archive/v1.2.8.tar.gz",
        "strip_prefix": "zlib-1.2.8",
        "build_file": str(Label("//protobuf:build_file/com_github_madler_zlib.BUILD")),
    },

    # grpc++ expects //external:zlib
    "zlib": {
        "rule": "bind",
        "actual": "@com_github_madler_zlib//:zlib",
    },

    # grpc++ expects "//external:protobuf_clib"
    "protobuf_clib": {
        "rule": "bind",
        "actual": "@com_github_google_protobuf//:protobuf",
    },

    # grpc++ expects //external:nanopb
    "nanopb": {
        "rule": "bind",
        "actual": "@com_github_grpc_grpc//third_party/nanopb",
    },

    # Bind the executable cc_binary grpc plugin into
    # //external:protoc_gen_grpc_cpp.  Expects
    # //external:protobuf_compiler. TODO: is it really necessary to
    # bind it in external?
    "protoc_gen_grpc_cpp": {
        "rule": "bind",
        "actual": "@com_github_grpc_grpc//:grpc_cpp_plugin",
    },

    # Bind the protobuf proto_lib into //external.  Required for
    # compiling the protoc_gen_grpc plugin
    "protobuf_compiler": {
        "rule": "bind",
        "actual": "@com_github_google_protobuf//:protoc_lib",
    },

    # GTest is for our own internal cc tests.
    "gtest": {
        "rule": "new_http_archive",
        "url": "https://github.com/google/googletest/archive/ed9d1e1ff92ce199de5ca2667a667cd0a368482a.tar.gz",
        "strip_prefix": "googletest-ed9d1e1ff92ce199de5ca2667a667cd0a368482a",
        "build_file": str(Label("//protobuf:build_file/gtest.BUILD")),
    },

}
