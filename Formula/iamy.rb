class Iamy < Formula
  desc "Envato fork of 99Designs IAMy IAM Object and S3 Bucket Policy Management tool"
  homepage "https://github.com/envato/iamy"
  url "https://github.com/envato/iamy/archive/refs/tags/v2.4.4.tar.gz"
  version "2.4.4+envato"
  sha256 "c8d859a7b34e743cc135b3c6fe7903a725faa71e01f23cb060b39f7f361c44cd"
  license "MIT"

  bottle do
    root_url "https://github.com/envato/iamy/releases/tag/v2.4.4"
    sha256 cellar: :any_skip_relocation, big_sur: "8b37ab085ef3785e8f7bc8c25b1d61b0e0b489a7585e4febe142005d5141d39a"
  end

  depends_on "go" => :build
  depends_on "awscli"

  def install
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
