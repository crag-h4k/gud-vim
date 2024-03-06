package policy

default allow = false

allow {
    input.user.rules[_] == "admin"
}
