I'm currently writing an [authentication plugin](https://github.com/neilstuartcraig/TDPAHAuthPlugin) for [actionHero](http://actionherojs.com/) - it's a NodeJS module with a [MongoDB](http://www.mongodb.org/) backend. Usually, I'd use [Mocha](http://visionmedia.github.io/mocha/) as a test runner and run my tests automatically (via [Travis CI](https://travis-ci.org)) when i commit/push to [GitHub](https://github.com/). In this instance though, I have some oddball issue which means that the MongoDB connection/driver just won't work under Mocha.

Owing to the above, I elected to bypass Mocha for the moment at least and just write the tests "raw". I knew I could do this as I recalled reading that Travis essentially uses the process exit status as the marker for success or failure (exit code 0 being success, anything else being failure). The issue was that I wanted to maintain several test files and to run them all on each commit/push. Usually, Mocha, as the test runner, would handle this for me but without Mocha, I was somewhat stuck.

To cut a long story short, with a couple of tests, I determined that the following works just fine to run multiple, independent test scripts via Travis and to record a build error if any one of them fails:

package.json file:
```
...
"scripts":
{
    "test": "node ./test/test1.js; node ./test/test2.js"; node ./test/test3.js";
}
```

Then in the test files, exit with relevant codes to show test success/failure e.g:

```
...
if(testWasSuccessful)
{
	process.exit(0);
}
else
{
	process.exit(1);
]
```

Obviously, it's not ideal having to list all the test files manually and I could (and maybe will) create a small globbing test runner/wrapper but this gets me off the starting blocks. Maybe this will help someone else in a similar situation.