set -x
function compile_fuzzer {
    fuzzer=$(basename $1)

    # Instrument all Go files relevant to this fuzzer, compile and store in $fuzzer.a
    GOOS=linux go-fuzz-build -o "${fuzzer}".zip github.com/dvyukov/go-fuzz-corpus/"${fuzzer}"

    zip -j -r "${fuzzer}"_seed_corpus.zip ./"${fuzzer}"/corpus/
    ./fuzzit create job --additional-corpus "${fuzzer}"_seed_corpus.zip  --engine go-fuzz --type fuzzing fuzzitdev-gh/"${fuzzer}" "${fuzzer}.zip"

}

# export -f compile_fuzzer


wget -O fuzzit https://github.com/fuzzitdev/fuzzit/releases/latest/download/fuzzit_Darwin_x86_64
chmod a+x fuzzit

compile_fuzzer asn1
#compile_fuzzer bzip2
compile_fuzzer csv
compile_fuzzer elliptic
compile_fuzzer flate
compile_fuzzer fmt
#compile_fuzzer gif
compile_fuzzer gzip
compile_fuzzer httpreq
compile_fuzzer httpresp
compile_fuzzer jpeg
compile_fuzzer json
compile_fuzzer lzw
compile_fuzzer mime
compile_fuzzer multipart
compile_fuzzer png
compile_fuzzer tar
compile_fuzzer time
#compile_fuzzer url
compile_fuzzer xml
compile_fuzzer zip
compile_fuzzer zlib

