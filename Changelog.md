# Changelog

## v3.1.0, 2020-04-16

### Added

- 'shallow_clone()', 'attach_back(n = nil)', 'attach_front(n = nil
)', 'detach_back()', and 'detach_front()' methods.
- Test constants.

### Edited

- Gem Specification. Bumped the interface dependency.
- Tests. Added 'shallow_clone()', 'attach_back(n = nil)', 'attach_front(n = nil
)', 'detach_back()', and 'detach_front' method tests.

### Fixed

## v3.0.0, 2020-04-15

### Added

- 'b()', 'd()', and 'f()' public methods.
- 'back_ref()', 'data_ref()', and 'front_ref()' protected methods.
- Tests covering additions and editions.

### Edited

- Interface dependency. 1.0.0 -> 2.0.0.
- Moved 'data()', 'back()', and 'front()' methods.
- Factored tests.
- Factored test constants.
- Formatted node_impl_test.rb.

### Fixed

- Inifinite loop bug in '==' method.

## v2.0.0, 2020-04-10

### Added

- Added YARDocumentation.
- Removed node_helper.rb and its references.
- clone_df() method. clone_df() deeply clones the receiver and freezes its
 attribute references.
- GNU General Public License, Version 3.
- A .yardopts file.

### Edited

- Rewrote the Gem Specification.
- Edited dependencies. Updated the node interface version, added the data
 library, and added the node_error library.
- Copyright statements.
- Rewrote InspectHelper.
- 'require' statements.
- inspect() factor.
- node_impl_test.rb format.
- node_impl_test.rb tests.

### Fixed

- back(), data(), and front().
- back=, data=, and front= privacy.
- back=, data=, and front= exception handling.
- inspect() diagram.
- README.md's Installation and Documentation links.
- substitute() exception handling. 

## v1.0.0, 2020-03-22

### Added

- inspect() helper module InspectHelper.
- inspect returns a Node diagram.
- Invalid arguments raise errors.
- Tests, test coverage. 

### Edited

- Version: 1.0.0.
- Formatting.
- Gem specification development dependencies: added the interface.
- copy_constructor() became overridden clone().
- README.md.

### Fixed

- data() returned a data clone.
- back() returned a back copy.
- front() returned a front copy.
- back, data, and front setters were private.
- Attribute equality operator.
