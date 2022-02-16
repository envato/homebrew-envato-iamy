class Iamy < Formula
  desc "Envato fork of 99Designs IAMy IAM Object and S3 Bucket Policy Management tool"
  homepage "https://github.com/envato/iamy"
  url "https://github.com/envato/iamy/archive/refs/tags/v4.0.0.tar.gz"
  version "4.0.0+envato"
  sha256 "5e5718e60df9bf549d9885e62e0466c1ddf24b5150980c584cad4f4f1004b8c8"
  license "MIT"

  bottle do
    root_url "https://github.com/envato/homebrew-envato-iamy/releases/download/iamy-4.0.0+envato"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c8dc4945abcdca45e88de96854c167400917bab8d82b6756dd6fe50360d90f7d"
    sha256 cellar: :any_skip_relocation, big_sur:       "8ac693c8316ef6266669b636d27bdd509c0dca63ab6c8a0c71e3cc63337ba3bd"
  end

  depends_on "go" => :build
  depends_on "awscli"

  def install
    ENV["CGO_CFLAGS"] = "-mmacosx-version-min=10.15"
    ENV["CGO_LDFLAGS"] = "-mmacosx-version-min=10.15"
    system "go", "build", *std_go_args, "-ldflags",
            "-s -w -X main.Version=v#{version}"
  end

  test do
    ENV.delete "AWS_ACCESS_KEY"
    ENV.delete "AWS_SECRET_KEY"
    output = shell_output("#{bin}/iamy pull 2>&1", 1)
    assert_match "Can't determine the AWS account", output
  end
end
