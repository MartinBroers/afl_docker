# Copyright (C) 2019 Martin Broers <broers.martin@gmail.com>

# We need to base on a slightly older version than the latest,
# as afl does not run on clang-10.
FROM alpine:3.10

RUN apk add --update --no-cache \
	autoconf \
	automake \
	bash \
	clang \
	clang-dev \
	dpkg \
	dumb-init \
	g++ \
	gcc \
	git \
	gnuplot \
	lld \
	llvm-dev \
	make \
	musl-dev 

RUN \
	ln -sf /usr/bin/clang /usr/bin/cc && \
	ln -sf /usr/bin/clang++ /usr/bin/c++ && \
	\
	update-alternatives --install /usr/bin/cc cc /usr/bin/clang 10 && \
	update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 10 && \
	update-alternatives --install /usr/bin/ld ld /usr/bin/lld 10 && \
	\
	update-alternatives --auto cc && \
	update-alternatives --auto c++ && \
	update-alternatives --auto ld && \
	\
	update-alternatives --display cc && \
	update-alternatives --display c++ && \
	update-alternatives --display ld && \
	\
	ls -l /usr/bin/cc /usr/bin/c++

# Download afl sources and compile them
RUN \
	wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz && \
	tar xvf afl-latest.tgz && \
	cd afl-* && \
	make && \
	make -C llvm_mode CXX=g++ && \
	make install

COPY "docker-entrypoint.sh" "/docker-entrypoint.sh"

ENTRYPOINT [ "/docker-entrypoint.sh" ]
