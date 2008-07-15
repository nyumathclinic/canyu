#!/usr/bin/perl -w

# $Id$
# $HeadURL$
# script to remove some entities from HTML files
# Matthew Leingang
# $Date$

while (<>) {
  # de-ligature
  s/&#xFB00;/ff/g;
  s/&#xFB03;/ffi/g;
  s/&#xFB01;/fi/g;
  s/&#xFB02;/fl/g;
  # de-hex
  s/&#(x[0-9A-F]{2,4});/'&#' . hex('0' . $1) . ';'/ge;
  print;
}
