How to use:

- built the image with `docker build -t kani-test .`
- run the container with the mounted libsignal project like this `docker run --rm -it -v ~/git_repos/libsignal:/work kani-test`
- inside the container: `cd rust/core/src/curve`
- run kani from there `with cargo kani --harness kani_proof_ct_is_zero`
