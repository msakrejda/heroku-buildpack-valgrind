# Heroku Buildpack: Valgrind

This is the [Heroku buildpack][buildpack] for [Valgrind][valgrind].

N.B.: there are probably better debugging approaches in most
situations; this should be considered a last resort.


## Getting Started

This buildpack installs Valgrind and some debug symbols alongside your
code, allowing you to run your application in a dyno under
Valgrind. It adds a shell function to your environment that is a thin
wrapper for the `valgrind` command; you should be able to use it like
`valgrind` itself.

First, change your application to run under Valgrind:

```console
maciek@mothra:~/code/my-app$ git diff
diff --git a/Procfile b/Procfile
index 9d7d0d2..d5f3106 100644
--- a/Procfile
+++ b/Procfile
@@ -1,2 +1,2 @@
-web: node static/server.js
+web: valgrind node static/server.js
maciek@mothra:~/code/my-app$ git commit Procfile -m "Run under valgrind"
```

Then tail your application logs

```console
git logs --tail --ps web --app my-app
```

and in a separate console, deploy to Heroku:

```console
git push heroku master
```

As your app starts up, you will see the following output from Valgrind:

```
2016-08-25T19:00:34.675244+00:00 app[web.1]: ==6== Memcheck, a memory error detector
2016-08-25T19:00:34.675302+00:00 app[web.1]: ==6== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
2016-08-25T19:00:34.675308+00:00 app[web.1]: ==6== Using Valgrind-3.11.0 and LibVEX; rerun with -h for copyright info
2016-08-25T19:00:34.675308+00:00 app[web.1]: ==6== Command: node static/server.js
2016-08-25T19:00:34.675309+00:00 app[web.1]: ==6==
```

If Valgrind finds any problems, you will see more output, similarly
prefixed.

Note that Valgrind will considerably slow down your application, to
the point you may hit the Heroku [boot timeout][boot-timeout]. You may
need to contact Support to have the limit increased (and after the
limit is increased, you may need to deploy a new version of your app
for it to pick up the new boot timeout).

## THIS IS BETA SOFTWARE

Thanks for trying it out. If you find any problems, please report an
issue and include your other buildpacks and any relevant output.

Note that for the moment, the buildpack output is very verbose to make
it easier to track down errors.

[buildpack]: http://devcenter.heroku.com/articles/buildpacks
[valgrind]: http://valgrind.org/
[boot-timeout]: https://devcenter.heroku.com/articles/limits#boot-timeout
