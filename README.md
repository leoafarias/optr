<p align="center"><image src="https://raw.githubusercontent.com/leoafarias/optr/master/optr-logo.png" width="300px"/></p>

# OPTR - One Password to Rule

## Flutter #Hack20 - Cyberpunk

<p> <a href="https://youtu.be/MAFTLxvyIPQ"><image src="https://raw.githubusercontent.com/leoafarias/optr/master/video.png" width="300px"/></a></p>

Concepta Team: [Leo Farias](https://github.com/leoafarias) and [Ianko Leite](https://github.com/ianko)

## Pitch

Are you ready for password freedom? Create easy to remember, impossible to guess unique passwords. How would you feel if you could recover all your credentials from memory? Well.. all that is possible. I will see you on the other side.

## Motivation

- Passwords are part of our day to day life.
- We are highly dependent on online services that require credentials.
- Are password managers secure, and do we trust them? [Password Managers have security flaws](https://www.washingtonpost.com/technology/2019/02/19/password-managers-have-security-flaw-you-should-still-use-one)

## The Deterministic approach and it's flaws

There are a lot of discussion about deterministic approach to a password manager. However the average user would be much better off using a deterministic password then their current password.

[Only 20% of users use different passwords for the online logins](https://www.statista.com/statistics/763091/us-use-of-same-online-passwords/)

## Ground Rules

We are minimizing the scope on how we want to tackle this problem, so it's essential we set some limitations and rules on how we will approach it.

- Passwords should be compliant with the latest NIST guidelines.
- We don't plan on creating passwords that are compatible with every single service out there. Some online services have unreasonable requirements. The 80/20 rule will apply in this case.
- You should still use a password manager. This might seem controversial, however being able to remember all your password is great, but at least in the beginning we will assume a password manager is used on day to day routine.
- Therefore the main focus on this is being able to recover all your password, when not having access to your password manager. i.e. Losing your master key, not having quick access when you need it, and etc.

## Goal

The main goal initially is to be able to create a straightforward system in which you can recover your passwords from memory if it's ever needed.
