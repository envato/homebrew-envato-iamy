class Iamy < Formula
  desc "Envato fork of 99Designs IAMy IAM Object and S3 Bucket Policy Management tool"
  homepage "https://github.com/envato/iamy"
  url "https://github.com/envato/iamy/archive/refs/tags/v3.2.1.tar.gz"
  version "3.2.1+envato"
  sha256 "1aec0b297023ae3cc00815f4c722cbc10f134a26037ffe5673cc00f362d3aeb3"
  license "MIT"

  bottle do
    root_url "https://github.com/envato/homebrew-envato-iamy/releases/download/iamy-3.2.1+envato"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e83eaa51973e785b2f2b1ed07b7918700b8f426a12a21c891520484a914929b9"
    sha256 cellar: :any_skip_relocation, catalina:      "13f578576a17698d185b932f5b4daceceacab7498a436d3efbce7123183710a7"
    sha256 cellar: :any_skip_relocation, big_sur:       "648ca9befed1a9dcbce9e412ca620f7accf3df477d68009b68e711f3c16b0cec"
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
