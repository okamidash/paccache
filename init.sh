# Make Data Dir
if [ ! -d /cache/community ]; then
    mkdir -p /cache/community/os/x86_64/
fi

if [ ! -d /cache/core ]; then
    mkdir -p /cache/core/os/x86_64/
fi

if [ ! -d /cache/extra ]; then
    mkdir -p /cache/extra/os/x86_64/
fi

if [ ! -d /cache/multilib ]; then
    mkdir -p /cache/multilib/os/x86_64/
fi

