# 0.18.1 is not compatible with Swift >=3.1
FROM norionomura/sourcekit:302

ENV SWIFTLINT_TAG=0.18.1
ENV SWIFTLINT_REPO_DIR=swiftlint-repo

# swiftlint
WORKDIR "${SWIFTLINT_REPO_DIR}"

RUN git clone https://github.com/realm/SwiftLint --branch "${SWIFTLINT_TAG}" --depth 1 .

RUN swift build --configuration release \
    && mv .build/release/swiftlint /usr/bin/swiftlint \
    && mv .build/release/*.so /usr/lib/swift/linux/x86_64/ \
    && mv .build/release/*.swiftmodule /usr/lib/swift/linux/x86_64/ \
    && cd .. \
    && rm -rf "${SWIFTLINT_REPO_DIR}"

RUN swiftlint version

# danger
RUN apt-get update \
    && apt-get install -y ruby \
    && gem install bundler danger

RUN danger --version
