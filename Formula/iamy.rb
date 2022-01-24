class Iamy < Formula
  desc "Envato fork of 99Designs IAMy IAM Object and S3 Bucket Policy Management tool"
  homepage "https://github.com/envato/iamy"
  url "https://github.com/envato/iamy/archive/refs/tags/v3.3.0.tar.gz"
  version "3.3.0+envato"
  sha256 "d73b22eca95f941df00ed5907130b280626e6680dbf48d693904d7f3d54457d6"
  license "MIT"

  bottle do
    root_url "https://github.com/envato/homebrew-envato-iamy/releases/download/iamy-3.3.0+envato"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "853b62f3eea171b93d5251f4f6163ff43299783a70eae664ec6871221ea01587"
    sha256 cellar: :any_skip_relocation, big_sur: "9e70a2f7e168fccd2c69b5f31d5d2dbf8556fb8da31d593a96e8ec40b7537034"
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
