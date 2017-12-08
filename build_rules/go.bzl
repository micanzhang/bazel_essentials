"""Go related build rules."""

load("@io_bazel_rules_go//go:def.bzl", "go_binary")


_STATIC_LINK_FLAGS = [
    "-linkmode",
    "external",
    "-extldflags",
    "-static",
]

def static_go_binary(name, **args):
  """Produce statically linked go binary which may be put in a minimal docker.

  The typical go binary produced is about 12M, which is put into a minimal
  docker such as alpine to produce deployable images of size less than 20M.

  WARNING: It is unfortunate that the link flags only work with gcc, not clang,
  which in practice means the target will not build on Mac out of box.
  """
  if "clinkopts" in args:
    args["clinkopts"] += _STATIC_LINK_FLAGS
  else:
    args["clinkopts"] = _STATIC_LINK_FLAGS
  go_binary(name=name, **args)
