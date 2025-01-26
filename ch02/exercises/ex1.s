


.global _start


_start: movn w0, #79
        add w0, w0, #1

# Setup program exit
# exit code is from register w0
mov x8, #93
svc 0
