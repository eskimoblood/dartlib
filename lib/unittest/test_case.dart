// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/**
 * testcase.dart: this file is sourced by unittest.dart. It defines [TestCase]
 * and assumes unittest defines the type [TestFunction].
 */


/** Summarizes information about a single test case. */
class TestCase {
  /** Identifier for this test. */
  final int id;

  /** A description of what the test is specifying. */
  final String description;

  /** The body of the test case. */
  final TestFunction test;

  /** Total number of callbacks to wait for before the test completes. */
  int callbacks;

  /** Error or failure message. */
  String message = '';

  /**
   * One of [_PASS], [_FAIL], or [_ERROR] or [null] if the test hasn't run yet.
   */
  String result;

  /** Stack trace associated with this test, or null if it succeeded. */
  String stackTrace;

  /** The group (or groups) under which this test is running. */
  final String currentGroup;

  Date startTime;

  Duration runningTime;

  TestCase(this.id, this.description, this.test, this.callbacks)
  : currentGroup = _currentGroup;

  bool get isComplete() => result != null;

  void pass() {
    result = _PASS;
  }

  void fail(String msg, String stack) {
    result = _FAIL;
    this.message = msg;
    this.stackTrace = stack;
  }

  void error(String msg, String stack) {
    result = _ERROR;
    this.message = msg;
    this.stackTrace = stack;
  }
}
