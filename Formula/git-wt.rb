class GitWt < Formula
  desc "Typed, provisioned git worktrees for Rails apps"
  homepage "https://github.com/OutlawAndy/git-wt"
  url "https://github.com/OutlawAndy/git-wt/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "20c2a1b6df88d55c8f5e7ddf1399e2ed74948a39497d0d66264802a6fe0de490"
  license "MIT"

  def install
    bin.install "bin/git-wt"
    man1.install "share/man/man1/git-wt.1"
  end

  def caveats
    <<~EOS
      To have `wt` cd into the worktree it creates, add to ~/.zshrc:
        eval "$(git wt --init zsh)"
    EOS
  end

  test do
    system "git", "init", "-q", "-b", "main", testpath/"repo"
    cd testpath/"repo" do
      system "git", "-c", "user.name=t", "-c", "user.email=t@t", "commit", "-q", "--allow-empty", "-m", "init"
      assert_equal "#{testpath}/repo/.worktrees/feat/x",
                   shell_output("#{bin}/git-wt --no-provision feat x 2>/dev/null").chomp
    end
  end
end
