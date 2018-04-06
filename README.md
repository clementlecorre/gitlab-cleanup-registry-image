# gitlab-cleanup-registry-image

Tooling for cleanup gitlab registy

## list-gitlab-registry-all-project.sh

Output
```
18 images : namespace/zegsapgozu
6 images : namespace/ezavetiene
4 images : namespace/mebikelhup
326 images : namespace/vugakasuwu
6 images : namespace/sunizlaguo
15 images : namespace/cogimriutz
20 images : namespace/nadasgisac
30 images : namespace/sofikicujw

```

## prune-gitlab-registry-project.sh


Configure regex matching pattern `REGEX_MATCHING="^issue-[0-9]+"`

Output
```
[IGNORING] regisrty.gitlab.com/namespace/repo:latest
[IGNORING] regisrty.gitlab.com/namespace/repo:branch-master
[DELETING] regisrty.gitlab.com/namespace/repo:branch-8
    => sha256:a24ae4bcc1b47ef34c4f9cb0c50f00c3b4f293c8f6a571fd219a52da63285641
[DELETING] regisrty.gitlab.com/namespace/repo:branch-6
    => sha256:606cb527f3c50f1ffd04b0b424a1c12d58e852110fd8f71efeba313219e1b4d1
[DELETING] regisrty.gitlab.com/namespace/repo:branch-7
    => sha256:c063dcf4e86563bf392c804f7d0fdb69da274d6e8a3a12edb70852784902cd51
[DELETING] regisrty.gitlab.com/namespace/repo:branch-4
    => sha256:ee6ae8ccc01014e7e179366342eec6be62c2346f7ffeb8f39c7fe0e8c4348f81
[DELETING] regisrty.gitlab.com/namespace/repo:branch-9
    => sha256:6a80d8f4d34b294067e2b25509ee20c4666ad1c0ab3540cd0a5bc91157c6a1b1
[DELETING] regisrty.gitlab.com/namespace/repo:branch-5
    => sha256:ab585eaa3da7102a48ecaa116f32b7fb1d820d628e381565e09fe387f4be98a1
[DELETING] regisrty.gitlab.com/namespace/repo:branch-1
    => sha256:ace2b7537ddcb93d40450278c6b3f388bb500c04865d497b5c70ab56a89d34d1
[DELETING] regisrty.gitlab.com/namespace/repo:branch-1
    => sha256:5776ff479ee562b2d56944445637690ae12c3fa143513e606fd7029e17cda8b1
[DELETING] regisrty.gitlab.com/namespace/repo:branch-1
    => sha256:d28548a114ab0069d3414e56efa3f8b0d8175411dbd7fedefbc30c27ab43e061
[DELETING] regisrty.gitlab.com/namespace/repo:branch-1
    => sha256:41e164d1d11dcd5afd43985309ca9e4a157638a586307e5dc3408cfc8df868a1
```    