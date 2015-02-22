#!/usr/bin/perl

#
# Copyright 2012 Bywater Solutions
#
# This file is part of Koha.
#
# Koha is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# Koha is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with Koha; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

use Modern::Perl;

use CGI;

use C4::Auth;
use C4::Output;
use C4::Koha;

use C4::CourseReserves qw(GetCourse GetCourseReserves);

my $cgi = new CGI;

my ( $template, $borrowernumber, $cookie ) = get_template_and_user(
    {   template_name   => "opac-course-details.tt",
        query           => $cgi,
        type            => "opac",
        authnotrequired => 1,
        debug           => 1,
    }
);

my $course_id = $cgi->param('course_id');

die("No course_id given") unless ($course_id);

my $course = GetCourse($course_id);
my $course_reserves = GetCourseReserves( course_id => $course_id, include_items => 1, include_count => 1 );

$template->param(
    course          => $course,
    course_reserves => $course_reserves,
);

output_html_with_http_headers $cgi, $cookie, $template->output;
