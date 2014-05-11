# Collector

[![Version](http://cocoapod-badges.herokuapp.com/v/Collector/badge.png)](http://cocoadocs.org/docsets/Collector)
[![Platform](http://cocoapod-badges.herokuapp.com/p/Collector/badge.png)](http://cocoadocs.org/docsets/Collector)

A great way to handle migrations in your iOS or Mac app. Provides a simple API to define blocks of code to run to migrate your app from earlier versions to its current version.

## Features

- Define what needs to be run to migrate your app to specific versions in a declarative manner.
- Sub-migrations enable you to run additional migrations without changing your app's version number.
- Use multiple migration managers to migrate parts of your app independently (optional).

## Usage

`Collector` requires version numbers to be specified in a style similar to [Semantic Versioning](http://semver.org) (ex: `2.0.3`) but places no limit on the actual number of components in the version number (`2.0.3.9.6` would be a valid version number). `Collector` also has its own syntax to refer to version numbers when it comes to sub-migrations (see below).

#### Basics

Using `Collector` is a piece of cake. First, obtain a migration manager instance:

```objc
Collector *manager = [Collector migrationManager];
```
	
Then, specify code to run when migrating your app to specific versions:

```objc
[manager whenMigratingToVersion:@"1.1" run:^
{
	// Peform operations to migrate your app from version 1.0 to version 1.1
	[self migrateKeyedArchiveToCoreStorage];
}];

[manager whenMigratingToVersion:@"1.2.5" run:^
{
	// Perform operations to migrate your app from versions 1.1 and later to 1.2.5
	[self deleteCachedData];
}];

[manager whenMigratingToVersion:@"1.4" run:^
{
	// Perform operations to migrate your app from versions 1.2.5 and later to 1.4
	...
}];
```

This code should run each time your app launches so that the migration manager can do its job.

#### Behavior

- Runs actions (if appropriate) as soon as `-whenMigratingToVersion:run:` is called.
- Runs all migrations from the version of the last app launch to the current version.
- Considers the current version to be the version defined in the info plist (CFBundleShortVersionString) unless [specified manually](#manual-current-version).

As an example, given the migrations above, if the last version of the app that the user launched was version `1.1` and the user is now launching version `1.4`, then `Collector` would run migrations `1.2.5` and `1.4`. Migration `1.1` would not run at that moment because it would already have been run when the app was launched as version `1.1`.

#### Sub-Migrations

Sometimes it can be useful to run migrations without changing your app's version number. Sub-migrations are meant for this:

```objc
[manager whenMigratingToVersion:@"1.1" run:^
{
	// Peform operations to migrate your app from version 1.0 to version 1.1
	[self migrateKeyedArchiveToCoreStorage];
}];

[manager whenMigratingToVersion:@"1.1-1" run:^
{
	// Perform operations to migrate your app from version 1.1 to sub-migration 1.1-1
}];

[manager whenMigratingToVersion:@"1.1-2" run:^
{
	// Perform operations to migrate your app from sub-migration 1.1-1 to sub-migration 1.1-2
}];
```

When encountering sub-migrations, `Collector` runs all sub-migrations that it hasn't encountered yet for versions earlier than or equal to the current app version. In the example above, if the app version is `1.1`, then all three migrations would run. Adding another migration with version `1.1-3` then starting the app again would run that migration, but not the other migrations because they have already been run.

<a name="manual-current-version"></a>
#### Using Multiple Migration Managers

If you'd rather use multiple migration managers to handle migrations in your app, you must obtain named migration managers. It could be a good idea to use the name of the class in which you're performing the migration as the migration manager's name, but that's up to you.

```objc
NSString *className = NSStringFromClass([self class]);
Collector *manager = [Collector migrationManagerWithName:className];
```

Afterwards, you can use your named migration managers totally independently. Define migrations for different version numbers, run blocks of code that affect different aspects of your app entirely, etc.

#### Providing the Current Version Manually

If `Collector`'s default behavior where CFBundleShortVersionString is considered as the current version doesn't fit your needs, you can also provide the current version manually:

	NSString *version = [self obtainCurrentVersionNumberInSomeWay];
	Collector *manager = [Collector migrationManagerWithCurrentVersion:version];

## Installation

Collector is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "Collector"

## Author

Michaël Fortin (fortinmike@irradiated.net)

## License

Collector is available under the MIT license. See the LICENSE file for more info.

