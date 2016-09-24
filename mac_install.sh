bundle config build.eventmachine --with-cppflags=-I$(brew --prefix openssl)/include
ARCHFLAGS="-arch x86_64" bundle install
