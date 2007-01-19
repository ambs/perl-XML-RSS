#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 152;

use XML::RSS;

sub contains
{
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    my ($rss, $sub_string, $msg) = @_;
    my $rss_output = $rss->as_string();
    my $ok = ok (index ($rss_output,
        $sub_string) >= 0,
        $msg
    );
    if (! $ok)
    {
        diag("Could not find the substring [$sub_string] in:{{{{\n$rss_output\n}}}}\n");
    }
}

sub not_contains
{
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    my ($rss, $sub_string, $msg) = @_;
    ok ((index ($rss->as_string(),
        $sub_string) < 0),
        $msg
    );
}

sub create_rss_1
{
    my $args = shift;
    # my $rss = new XML::RSS (version => '0.9');
    my $rss = new XML::RSS (version => $args->{version});
    my $image_link = exists($args->{image_link}) ? $args->{image_link} : 
        "http://freshmeat.net/";

    my $extra_image_params = $args->{image_params} || [];

    $rss->channel(
        title => "freshmeat.net",
        link  => "http://freshmeat.net",
        description => "the one-stop-shop for all your Linux software needs",
        );

    $rss->image(
        title => "freshmeat.net",
        url   => "0",
        link  => $image_link,
        @{$extra_image_params},
        );

    $rss->add_item(
        title => "GTKeyboard 0.85",
        link  => "http://freshmeat.net/news/1999/06/21/930003829.html"
        );

    return $rss;
}


sub create_no_image_rss
{
    my $args = shift;
    # my $rss = new XML::RSS (version => '0.9');
    my $rss = new XML::RSS (version => $args->{version});

    $rss->channel(
        title => "freshmeat.net",
        link  => "http://freshmeat.net",
        description => "the one-stop-shop for all your Linux software needs",
        );

    $rss->add_item(
        title => "GTKeyboard 0.85",
        link  => "http://freshmeat.net/news/1999/06/21/930003829.html"
        );

    return $rss;
}

sub create_item_with_0_rss
{
    my $args = shift;
    # my $rss = new XML::RSS (version => '0.9');
    my $rss = new XML::RSS (version => $args->{version});
    my $image_link = exists($args->{image_link}) ? $args->{image_link} : 
        "http://freshmeat.net/";

    my $extra_image_params = $args->{image_params} || [];
    my $extra_item_params = $args->{item_params} || [];

    $rss->channel(
        title => "freshmeat.net",
        link  => "http://freshmeat.net",
        description => "the one-stop-shop for all your Linux software needs",
        );

    $rss->image(
        title => "freshmeat.net",
        url   => "0",
        link  => $image_link,
        @{$extra_image_params},
        );

    $rss->add_item(
        title => "0",
        link  => "http://rss.mytld/",
        @{$extra_item_params},
        );

    return $rss;
}

sub create_textinput_with_0_rss
{
    my $args = shift;
    # my $rss = new XML::RSS (version => '0.9');
    my $rss = new XML::RSS (version => $args->{version});
    my $image_link = exists($args->{image_link}) ? $args->{image_link} : 
        "http://freshmeat.net/";

    my $extra_image_params = $args->{image_params} || [];
    my $extra_item_params = $args->{item_params} || [];
    my $extra_textinput_params = $args->{textinput_params} || [];

    $rss->channel(
        title => "freshmeat.net",
        link  => "http://freshmeat.net",
        description => "the one-stop-shop for all your Linux software needs",
        );

    $rss->image(
        title => "freshmeat.net",
        url   => "0",
        link  => $image_link,
        @{$extra_image_params},
        );

    $rss->add_item(
        title => "0",
        link  => "http://rss.mytld/",
        @{$extra_item_params},
        );

    $rss->textinput(
        (map { $_ => 0 } (qw(link title description name))),
        @{$extra_textinput_params},
    );

    return $rss;
}

sub create_channel_rss
{
    my $args = shift;
    # my $rss = new XML::RSS (version => '0.9');
    my $rss = new XML::RSS (version => $args->{version});

    my $extra_channel_params = $args->{channel_params} || [];
    my @build_date =
        ($args->{version} eq "2.0" && !$args->{omit_date}) ?
            (lastBuildDate => "Sat, 07 Sep 2002 09:42:31 GMT",) :
            ();

    $rss->channel(
        title => "freshmeat.net",
        link  => "http://freshmeat.net",
        description => "Linux software",
        @build_date,
        @{$extra_channel_params},
        );

    $rss->add_item(
        title => "GTKeyboard 0.85",
        link  => "http://freshmeat.net/news/1999/06/21/930003829.html"
        );

    return $rss;
}

sub create_skipHours_rss
{
    my $args = shift;
    # my $rss = new XML::RSS (version => '0.9');
    my $rss = new XML::RSS (version => $args->{version});

    my $extra_channel_params = $args->{channel_params} || [];
    my $extra_skipHours_params = $args->{skipHours_params} || [];
    my @build_date =
        ($args->{version} eq "2.0" && !$args->{omit_date}) ?
            (lastBuildDate => "Sat, 07 Sep 2002 09:42:31 GMT",) :
            ();

    $rss->channel(
        title => "freshmeat.net",
        link  => "http://freshmeat.net",
        description => "Linux software",
        @build_date,
        @{$extra_channel_params},
        );

    $rss->add_item(
        title => "GTKeyboard 0.85",
        link  => "http://freshmeat.net/news/1999/06/21/930003829.html"
        );

    $rss->skipHours(@{$extra_skipHours_params});

    return $rss;
}

sub create_skipDays_rss
{
    my $args = shift;
    # my $rss = new XML::RSS (version => '0.9');
    my $rss = new XML::RSS (version => $args->{version});

    my $extra_channel_params = $args->{channel_params} || [];
    my $extra_skipDays_params = $args->{skipDays_params} || [];
    my @build_date =
        ($args->{version} eq "2.0" && !$args->{omit_date}) ?
            (lastBuildDate => "Sat, 07 Sep 2002 09:42:31 GMT",) :
            ();

    $rss->channel(
        title => "freshmeat.net",
        link  => "http://freshmeat.net",
        description => "Linux software",
        @build_date,
        @{$extra_channel_params},
        );

    $rss->add_item(
        title => "GTKeyboard 0.85",
        link  => "http://freshmeat.net/news/1999/06/21/930003829.html"
        );

    $rss->skipDays(@{$extra_skipDays_params});

    return $rss;
}

sub create_rss_with_image_w_undef_link
{
    my $args = shift;
    # my $rss = new XML::RSS (version => '0.9');
    my $rss = new XML::RSS (version => $args->{version});

    my $extra_image_params = $args->{image_params} || [];

    $rss->channel(
        title => "freshmeat.net",
        link  => "http://freshmeat.net",
        description => "the one-stop-shop for all your Linux software needs",
        );

    $rss->image(
        title => "freshmeat.net",
        url   => "0",
        @{$extra_image_params},
        );

    $rss->add_item(
        title => "GTKeyboard 0.85",
        link  => "http://freshmeat.net/news/1999/06/21/930003829.html"
        );

    return $rss;
}

sub create_item_rss
{
    my $args = shift;
    # my $rss = new XML::RSS (version => '0.9');
    my $rss = new XML::RSS (version => $args->{version});

    my $extra_item_params = $args->{item_params} || [];

    $rss->channel(
        title => "freshmeat.net",
        link  => "http://freshmeat.net",
        description => "the one-stop-shop for all your Linux software needs",
        );

    $rss->add_item(
        title => "Freecell Solver",
        link  => "http://fc-solve.berlios.de/",
        @$extra_item_params,
        );

    return $rss;
}

sub create_rss_without_item
{
    my $args = shift;
    # my $rss = new XML::RSS (version => '0.9');
    my $rss = new XML::RSS (version => $args->{version});

    $rss->channel(
        title => "freshmeat.net",
        link  => "http://freshmeat.net",
        description => "the one-stop-shop for all your Linux software needs",
        );

    return $rss;
}

{
    my $rss = create_no_image_rss({version => "0.9"});
    # TEST
    not_contains($rss, "<image>",
        "0.9 - if an image was not specified it isn't there."
    );
}

{
    my $rss = create_no_image_rss({version => "0.91"});
    # TEST
    not_contains($rss, "<image>",
        "0.91 - if an image was not specified it isn't there."
    );
}

{
    my $rss = create_no_image_rss({version => "1.0"});
    # TEST
    not_contains($rss, "<image rdf:about=\"",
        "1.0 - if an image was not specified it isn't there."
    );
    # TEST
    not_contains($rss, "<image rdf:resource=\"",
        "1.0 - if an image was not specified it isn't there."
    );
    
}

{
    my $rss = create_no_image_rss({version => "2.0"});
    # TEST
    not_contains($rss, "<image>",
        "1.0 - if an image was not specified it isn't there."
    );
}

{
    my $rss = create_rss_1({version => "0.9"});
    # TEST
    ok ($rss->as_string =~ m{<image>.*?<title>freshmeat.net</title>.*?<url>0</url>.*?<link>http://freshmeat.net/</link>.*?</image>}s,
         "Checking for image in RSS 0.9");
}

{
    my $rss = create_rss_1({version => "0.91"});
    # TEST
    ok ($rss->as_string =~ m{<image>.*?<title>freshmeat.net</title>.*?<url>0</url>.*?<link>http://freshmeat.net/</link>.*?</image>}s,
         "Checking for image in RSS 0.9.1");
}

{
    my $rss = create_rss_1({version => "1.0"});
    # TEST
    ok ($rss->as_string =~ m{<image rdf:about="0">.*?<title>freshmeat.net</title>.*?<url>0</url>.*?<link>http://freshmeat.net/</link>.*?</image>}s,
         "Checking for image in RSS 1.0");
    # TEST
    contains ($rss, 
        "</items>\n<image rdf:resource=\"0\" />\n",
        "1.0 - contains image rdf:resource."
    );
}

{
    my $rss = create_rss_1({version => "2.0"});
    # TEST
    ok ($rss->as_string =~ m{<image>.*?<title>freshmeat.net</title>.*?<url>0</url>.*?<link>http://freshmeat.net/</link>.*?</image>}s,
         "Checking for image in RSS 2.0");
}

{
    my $rss = create_rss_1({version => "0.9", image_link => "0",});
    # TEST
    ok (index($rss->as_string(),
            "<image>\n<title>freshmeat.net</title>\n<url>0</url>\n<link>0</link>\n</image>\n") >= 0,
        "Testing for link == 0 appearance in RSS 0.9"
    );
}

{
    my $version = "0.91";
    my $rss = create_rss_1({version => $version, image_link => "0",});
    # TEST
    ok (index($rss->as_string(),
            "<image>\n<title>freshmeat.net</title>\n<url>0</url>\n<link>0</link>\n</image>\n") >= 0,
        "Testing for link == 0 appearance in RSS $version"
    );
}

{
    my $version = "1.0";
    my $rss = create_rss_1({version => $version, image_link => "0",});
    # TEST
    ok (index($rss->as_string(),
            qq{<image rdf:about="0">\n<title>freshmeat.net</title>\n<url>0</url>\n<link>0</link>\n</image>\n}) >= 0,
        "Testing for link == 0 appearance in RSS $version"
    );
}

{
    my $version = "2.0";
    my $rss = create_rss_1({version => $version, image_link => "0",});
    # TEST
    ok (index($rss->as_string(),
            qq{<image>\n<title>freshmeat.net</title>\n<url>0</url>\n<link>0</link>\n</image>\n}) >= 0,
        "Testing for link == 0 appearance in RSS $version"
    );
}

{
    my $version = "0.91";
    my $rss = create_rss_1({
            version => $version, 
            image_params => [width => 0, height => 0, description => 0],
        }
    );
    # TEST
    contains($rss, 
            "<image>\n<title>freshmeat.net</title>\n<url>0</url>\n"
            . "<link>http://freshmeat.net/</link>\n"
            . "<width>0</width>\n<height>0</height>\n"
            . "<description>0</description>\n</image>\n",
        "Testing for width, height, description == 0 appearance in RSS $version"
    );
}

{
    my $rss = create_rss_1({
            version => "2.0", 
            image_params => [width => 0, height => 0, description => 0],
        }
    );
    # TEST
    contains($rss, 
            "<image>\n<title>freshmeat.net</title>\n<url>0</url>\n"
            . "<link>http://freshmeat.net/</link>\n"
            . "<width>0</width>\n<height>0</height>\n"
            . "<description>0</description>\n</image>\n",
        "2.0 - all(width, height, description) == 0 appearance"
    );
}

{
    my $rss = create_item_with_0_rss({version => "0.9"});
    # TEST
    contains(
        $rss,
        "<item>\n<title>0</title>\n<link>http://rss.mytld/</link>\n</item>",
        "0.9 - item/title == 0",
    );
}

{
    my $rss = create_item_with_0_rss({version => "0.91", 
            item_params => [description => "Hello There"],
        });
    # TEST
    contains(
        $rss,
        "<item>\n<title>0</title>\n<link>http://rss.mytld/</link>\n<description>Hello There</description>\n</item>",
        "0.9.1 - item/title == 0",
    );
}

{
    my $rss = create_item_with_0_rss({version => "0.91", 
            item_params => [description => "0"],
        });
    # TEST
    contains(
        $rss,
        "<item>\n<title>0</title>\n<link>http://rss.mytld/</link>\n<description>0</description>\n</item>",
        "0.9.1 - item/title == 0 && item/description == 0",
    );
}

{
    my $rss = create_item_with_0_rss({version => "1.0", 
            item_params => [description => "Hello There", about => "Yowza"],
        });
    # TEST
    contains(
        $rss,
        "<item rdf:about=\"Yowza\">\n<title>0</title>\n<link>http://rss.mytld/</link>\n<description>Hello There</description>\n</item>",
        "1.0 - item/title == 0",
    );
}

{
    my $rss = create_item_with_0_rss({version => "1.0", 
            item_params => [description => "0", about => "Yowza"],
        });
    # TEST
    contains(
        $rss,
        "<item rdf:about=\"Yowza\">\n<title>0</title>\n<link>http://rss.mytld/</link>\n<description>0</description>\n</item>",
        "1.0 - item/title == 0 && item/description == 0",
    );
}
# TODO : Test the dc: items.

{
    my @subs = (qw(title link description author category comments pubDate));
    my $rss = create_item_with_0_rss({version => "2.0", 
            item_params => 
            [
                map { $_ => 0 } @subs
            ],
        }
    );

    # TEST
    contains(
        $rss,
        ("<item>\n"
        . join("", map { "<$_>0</$_>\n" } @subs) 
        . "</item>"),
        "2.0 - item/* == 0 - 1",
    );
}

{
    my $rss = create_item_with_0_rss({version => "2.0", 
            item_params => 
            [
                title => "Foo&Bar",
                link => "http://www.mytld/",
                permaLink => "0",
            ],
        }
    );

    # TEST
    contains(
        $rss,
        ("<item>\n" .
         "<title>Foo&#x26;Bar</title>\n" .
         "<link>http://www.mytld/</link>\n" .
         "<guid isPermaLink=\"true\">0</guid>\n" .
         "</item>"
         ),
        "2.0 - item/permaLink == 0",
    );
}

{
    my $rss = create_item_with_0_rss({version => "2.0", 
            item_params => 
            [
                title => "Foo&Bar",
                link => "http://www.mytld/",
                guid => "0",
            ],
        }
    );

    # TEST
    contains(
        $rss,
        ("<item>\n" .
         "<title>Foo&#x26;Bar</title>\n" .
         "<link>http://www.mytld/</link>\n" .
         "<guid isPermaLink=\"false\">0</guid>\n" .
         "</item>"
         ),
        "2.0 - item/guid == 0",
    );
}

{
    # TEST:$num_iters=4;
    foreach my $s (
        ["Hercules", "http://www.hercules.tld/",],
        ["0", "http://www.hercules.tld/",],
        ["Hercules", "0",],
        ["0", "0",],
        )
    {
        my $rss = create_item_with_0_rss({version => "2.0",
                item_params => 
                [
                    title => "Foo&Bar",
                    link => "http://www.mytld/",
                    source => $s->[0],
                    sourceUrl => $s->[1],
                ],
            }
        );

        # TEST*$num_iters
        contains(
            $rss,
            ("<item>\n" .
             "<title>Foo&#x26;Bar</title>\n" .
             "<link>http://www.mytld/</link>\n" .
             "<source url=\"$s->[1]\">$s->[0]</source>\n" .
             "</item>"
             ),
            "2.0 - item - source = $s->[0] sourceUrl = $s->[1]",
        );
    }
}

{
    my $rss = create_no_image_rss({version => "0.9"});
    # TEST
    not_contains($rss, "<textinput>",
        "0.9 - if a textinput was not specified it isn't there."
    );
}

{
    my $rss = create_textinput_with_0_rss({version => "0.9"});
    # TEST
    contains(
        $rss,
        ("<textinput>\n" . join("", map {"<$_>0</$_>\n"} (qw(title description name link))) . "</textinput>\n"),
        "0.9 - textinput/link == 0",
    );
}

{
    my $rss = create_no_image_rss({version => "0.91"});
    # TEST
    not_contains($rss, "<textinput>",
        "0.9.1 - if a textinput was not specified it isn't there."
    );
}

{
    my $rss = create_textinput_with_0_rss({version => "0.91"});
    # TEST
    contains(
        $rss,
        ("<textinput>\n" . join("", map {"<$_>0</$_>\n"} (qw(title description name link))) . "</textinput>\n"),
        "0.9.1 - textinput/link == 0",
    );
}

{
    my $rss = create_no_image_rss({version => "1.0"});
    # TEST
    not_contains($rss, "<textinput rdf:about=",
        "1.0 - if a textinput was not specified it isn't there."
    );
    # TEST
    not_contains($rss, "<textinput rdf:resource=",
        "1.0 - if a textinput was not specified it isn't there."
    );
    
}

{
    my $rss = create_textinput_with_0_rss({version => "1.0"});
    # TEST
    contains(
        $rss,
        ("<textinput rdf:about=\"0\">\n" . join("", map {"<$_>0</$_>\n"} (qw(title description name link))) . "</textinput>\n"),
        "1.0 - textinput/link == 0",
    );
    # TEST
    contains(
        $rss,
        "<textinput rdf:resource=\"0\" />\n</channel>\n",
        "1.0 - textinput/link == 0 and textinput rdf:resource",
    );    
}


{
    my $rss = create_no_image_rss({version => "2.0"});
    # TEST
    not_contains($rss, "<textInput>",
        "2.0 - if a textinput was not specified it isn't there."
    );
}

{
    my $rss = create_textinput_with_0_rss({version => "2.0"});
    # TEST
    contains(
        $rss,
        ("<textInput>\n" . join("", map {"<$_>0</$_>\n"} (qw(title description name link))) . "</textInput>\n"),
        "2.0 - textinput/link == 0",
    );
}

{
    my $rss = create_channel_rss({version => "0.91"});
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "\n" .
        "<item>\n",
        "0.9.1 - if a channel/dc/language was not specified it isn't there."
    );
}

{
    my $rss = create_channel_rss({
            version => "0.91", 
            channel_params => [dc => { language => "0",},],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<language>0</language>\n" .
        "\n" .
        "<item>\n",
        "0.9.1 - channel/dc/language == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "0.91", 
            channel_params => [language => "0",],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<language>0</language>\n" .
        "\n" .
        "<item>\n",
        "0.9.1 - channel/language == 0"
    );
}

{
    my $rss = create_channel_rss({version => "1.0"});
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<items>\n",
        "1.0 - if a channel/dc/language was not specified it isn't there."
    );
}

{
    my $rss = create_channel_rss({
            version => "1.0", 
            channel_params => [dc => { language => "0",},],
        });
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<dc:language>0</dc:language>\n" .
        "<items>\n",
        "1.0 - channel/dc/language == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "1.0", 
            channel_params => [language => "0",],
        });
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<dc:language>0</dc:language>\n" .
        "<items>\n",
        "1.0 - channel/language == 0"
    );
}


{
    my $rss = create_channel_rss({version => "2.0"});
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" . 
        "\n" .
        "<item>\n",
        "2.0 - if a channel/dc/language was not specified it isn't there."
    );
}

{
    my $rss = create_channel_rss({
            version => "2.0", 
            channel_params => [dc => { language => "0",},],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<language>0</language>\n" .
        "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" . 
        "\n" .
        "<item>\n",
        "2.0 - channel/dc/language == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "2.0", 
            channel_params => [language => "0",],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<language>0</language>\n" .
        "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" . 
        "\n" .
        "<item>\n",
        "2.0 - channel/language == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "0.91", 
            channel_params => [rating => "0",],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<rating>0</rating>\n" .
        "\n" .
        "<item>\n",
        "0.9.1 - channel/rating == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "0.91", 
            channel_params => [rating => "Hello", dc => {rights => "0"},],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<rating>Hello</rating>\n" .
        "<copyright>0</copyright>\n" .
        "\n" .
        "<item>\n",
        "0.9.1 - channel/dc/copyright == 0"
    );
}


{
    my $rss = create_channel_rss({
            version => "0.91", 
            channel_params => [rating => "Hello", copyright => "0",],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<rating>Hello</rating>\n" .
        "<copyright>0</copyright>\n" .
        "\n" .
        "<item>\n",
        "0.9.1 - channel/copyright == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "2.0", 
            channel_params => [dc => {rights => "0"},],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<copyright>0</copyright>\n" .
        "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" . 
        "\n" .
        "<item>\n",
        "2.0 - channel/dc/rights == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "2.0", 
            channel_params => [copyright=> "0",],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<copyright>0</copyright>\n" .
        "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" . 
        "\n" .
        "<item>\n",
        "2.0 - channel/copyright == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "0.91", 
            channel_params => 
            [rating => "Hello", copyright => "Martha",docs => "0",],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<rating>Hello</rating>\n" .
        "<copyright>Martha</copyright>\n" .
        "<docs>0</docs>\n" .
        "\n" .
        "<item>\n",
        "0.9.1 - channel/docs == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "2.0", 
            channel_params => [copyright => "Martha", docs => "0",],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<copyright>Martha</copyright>\n" .
        "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" . 
        "<docs>0</docs>\n" .
        "\n" .
        "<item>\n",
        "2.0 - channel/docs == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "0.91", 
            channel_params => 
            [rating => "Hello", copyright => "Martha",
            docs => "MyDr. docs",dc => {publisher => 0}],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<rating>Hello</rating>\n" .
        "<copyright>Martha</copyright>\n" .
        "<docs>MyDr. docs</docs>\n" .
        "<managingEditor>0</managingEditor>\n" .
        "\n" .
        "<item>\n",
        "0.9.1 - channel/dc/publisher == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "0.91", 
            channel_params => 
            [rating => "Hello", copyright => "Martha",
            docs => "MyDr. docs",managingEditor => 0],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<rating>Hello</rating>\n" .
        "<copyright>Martha</copyright>\n" .
        "<docs>MyDr. docs</docs>\n" .
        "<managingEditor>0</managingEditor>\n" .
        "\n" .
        "<item>\n",
        "0.9.1 - channel/managingEditor == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "2.0", 
            channel_params => 
            [copyright => "Martha",
            docs => "MyDr. docs",managingEditor => 0],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<copyright>Martha</copyright>\n" .
        "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" . 
        "<docs>MyDr. docs</docs>\n" .
        "<managingEditor>0</managingEditor>\n" .
        "\n" .
        "<item>\n",
        "2.0 - channel/managingEditor == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "2.0", 
            channel_params => 
            [copyright => "Martha", docs => "MyDr. docs",
            dc => {publisher => 0}],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<copyright>Martha</copyright>\n" .
        "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" . 
        "<docs>MyDr. docs</docs>\n" .
        "<managingEditor>0</managingEditor>\n" .
        "\n" .
        "<item>\n",
        "2.0 - channel/dc/publisher == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "1.0", 
            channel_params => 
            [copyright => "Martha", dc => {publisher => 0}],
        });
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<dc:rights>Martha</dc:rights>\n" .
        "<dc:publisher>0</dc:publisher>\n" .
        "<items>\n",
        "1.0 - channel/dc/publisher == 0"
    );
}

{
    # Here we create an RSS 2.0 object and render it as 1.0 to get the
    # "managingEditor" field acknowledged.
    my $rss = create_channel_rss({
            version => "2.0", 
            channel_params =>
            [copyright => "Martha", managingEditor => 0,],
            omit_date => 1,
        });
    $rss->{output} = "1.0";
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<dc:rights>Martha</dc:rights>\n" .
        "<dc:publisher>0</dc:publisher>\n" .
        "<items>\n",
        "1.0 - channel/managingEditor == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "0.91", 
            channel_params => 
            [rating => "Hello", copyright => "Martha",
            docs => "MyDr. docs",dc => {creator => 0}],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<rating>Hello</rating>\n" .
        "<copyright>Martha</copyright>\n" .
        "<docs>MyDr. docs</docs>\n" .
        "<webMaster>0</webMaster>\n" .
        "\n" .
        "<item>\n",
        "0.9.1 - channel/dc/publisher == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "0.91", 
            channel_params => 
            [rating => "Hello", copyright => "Martha",
            docs => "MyDr. docs",webMaster => 0],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<rating>Hello</rating>\n" .
        "<copyright>Martha</copyright>\n" .
        "<docs>MyDr. docs</docs>\n" .
        "<webMaster>0</webMaster>\n" .
        "\n" .
        "<item>\n",
        "0.9.1 - channel/webMaster == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "1.0", 
            channel_params => 
            [copyright => "Martha", dc => {creator => 0}],
        });
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<dc:rights>Martha</dc:rights>\n" .
        "<dc:creator>0</dc:creator>\n" .
        "<items>\n",
        "1.0 - channel/dc/creator == 0"
    );
}

{
    # Here we create an RSS 2.0 object and render it as 1.0 to get the
    # "managingEditor" field acknowledged.
    my $rss = create_channel_rss({
            version => "2.0", 
            channel_params =>
            [copyright => "Martha", webMaster => 0,],
            omit_date => 1,
        });
    $rss->{output} = "1.0";
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<dc:rights>Martha</dc:rights>\n" .
        "<dc:creator>0</dc:creator>\n" .
        "<items>\n",
        "1.0 - channel/managingEditor == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "2.0", 
            channel_params => 
            [copyright => "Martha",
            docs => "MyDr. docs",webMaster => 0],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<copyright>Martha</copyright>\n" .
        "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" . 
        "<docs>MyDr. docs</docs>\n" .
        "<webMaster>0</webMaster>\n" .
        "\n" .
        "<item>\n",
        "2.0 - channel/webMaster == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "2.0", 
            channel_params => 
            [copyright => "Martha", docs => "MyDr. docs",
            dc => {creator => 0}],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<copyright>Martha</copyright>\n" .
        "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" . 
        "<docs>MyDr. docs</docs>\n" .
        "<webMaster>0</webMaster>\n" .
        "\n" .
        "<item>\n",
        "2.0 - channel/dc/creator == 0"
    );
}

{
    my $rss = create_no_image_rss({version => "0.91"});
    # TEST
    not_contains($rss, "<skipHours>",
        "0.91 - if skipHours was not specified it isn't there."
    );
}

{
    my $rss = create_skipHours_rss({
            version => "0.91", 
            skipHours_params => [ hour => "0" ],
        });
    # TEST
    contains($rss, "<skipHours>\n<hour>0</hour>\n</skipHours>\n",
        "0.91 - skipHours/hours == 0"
    );
}

{
    my $rss = create_no_image_rss({version => "2.0"});
    # TEST
    not_contains($rss, "<skipHours>",
        "2.0 - if skipHours was not specified it isn't there."
    );
}

{
    my $rss = create_skipHours_rss({
            version => "2.0", 
            skipHours_params => [ hour => "0" ],
        });
    # TEST
    contains($rss, "<skipHours>\n<hour>0</hour>\n</skipHours>\n",
        "2.0 - skipHours/hour == 0"
    );
}

{
    my $rss = create_no_image_rss({version => "0.91"});
    # TEST
    not_contains($rss, "<skipDays>",
        "0.91 - if skipDays was not specified it isn't there."
    );
}

{
    my $rss = create_skipDays_rss({
            version => "0.91", 
            skipDays_params => [ day => "0" ],
        });
    # TEST
    contains($rss, "<skipDays>\n<day>0</day>\n</skipDays>\n",
        "0.91 - skipDays/days == 0"
    );
}

{
    my $rss = create_no_image_rss({version => "2.0"});
    # TEST
    not_contains($rss, "<skipDays>",
        "2.0 - if skipDays was not specified it isn't there."
    );
}

{
    my $rss = create_skipDays_rss({
            version => "2.0", 
            skipDays_params => [ day => "0" ],
        });
    # TEST
    contains($rss, "<skipDays>\n<day>0</day>\n</skipDays>\n",
        "2.0 - skipDays/day == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "1.0", 
        });
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<items>\n",
        "1.0 - channel/dc/creator == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "1.0", 
            channel_params => 
            [copyright => 0,],
        });
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<dc:rights>0</dc:rights>\n" .
        "<items>\n",
        "1.0 - channel/copyright == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "1.0", 
            channel_params => 
            [dc => { rights => 0},],
        });
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<dc:rights>0</dc:rights>\n" .
        "<items>\n",
        "1.0 - channel/dc/rights == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "1.0", 
            channel_params => 
            [dc => { title => 0},],
        });
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<dc:title>0</dc:title>\n" .
        "<items>\n",
        "1.0 - channel/dc/title == 0"
    );
}

{
    my $rss = create_channel_rss({
            version => "1.0", 
            channel_params => 
            [syn => { updateBase=> 0},],
        });
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<syn:updateBase>0</syn:updateBase>\n" .
        "<items>\n",
        "1.0 - channel/syn/updateBase == 0"
    );
}

{
    my $rss = create_rss_1({version => "1.0", 
            image_params => [ dc => { subject => 0, }]
        });
    # TEST
    contains ($rss, 
        (qq{<image rdf:about="0">\n<title>freshmeat.net</title>\n} .
        qq{<url>0</url>\n<link>http://freshmeat.net/</link>\n} . 
        qq{<dc:subject>0</dc:subject>\n</image>}),
         "1.0 - Checking for image/dc/subject == 0");
}

{
    my $rss = create_item_with_0_rss({version => "1.0", 
            item_params => 
            [
                description => "Hello There",
                about => "Yowza",
                dc => { subject => 0,},
            ],
        });
    # TEST
    contains(
        $rss,
        "<item rdf:about=\"Yowza\">\n<title>0</title>\n<link>http://rss.mytld/</link>\n<description>Hello There</description>\n<dc:subject>0</dc:subject>\n</item>",
        "1.0 - item/dc/subject == 0",
    );
}

{
    my $rss = create_textinput_with_0_rss({version => "1.0",
            textinput_params => [dc => { subject => 0,},],
        });
    # TEST
    contains(
        $rss,
        ("<textinput rdf:about=\"0\">\n" . join("", map {"<$_>0</$_>\n"} (qw(title description name link dc:subject))) . "</textinput>\n"),
        "1.0 - textinput/dc/subject == 0",
    );
}

{
    # TEST:$num_fields=3;
    foreach my $field (qw(category generator ttl))
    {
        # TEST:$num_dc=2;
        foreach my $dc (1,0)
        {
            my $rss = create_channel_rss({
                    version => "2.0",
                    channel_params =>
                    [$dc ? 
                        (dc => {$field => 0 }) :
                        ($field => 0)
                    ],
                });
            # TEST*$num_fields*$num_dc
            contains($rss, "<channel>\n" .
                "<title>freshmeat.net</title>\n" .
                "<link>http://freshmeat.net</link>\n" .
                "<description>Linux software</description>\n" .
                "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" . 
                "<$field>0</$field>\n" .
                "\n" .
                "<item>\n",
                "2.0 - Testing for fields with an optional dc being 0. (dc=$dc,field=$field)"
            );
        }
    }
}

{
    my $rss = create_channel_rss({
            version => "0.91", 
            channel_params => [pubDate => "</pubDate><hello>There&amp;Everywhere</hello>"],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<pubDate>&#x3C;/pubDate&#x3E;&#x3C;hello&#x3E;There&#x26;amp;Everywhere&#x3C;/hello&#x3E;</pubDate>\n" .
        "\n" .
        "<item>\n",
        "0.9.1 - channel/pubDate Markup Injection"
    );
}

{
    my $rss = create_channel_rss({
            version => "0.91", 
            channel_params => [lastBuildDate => "</pubDate><hello>There&amp;Everywhere</hello>"],
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<lastBuildDate>&#x3C;/pubDate&#x3E;&#x3C;hello&#x3E;There&#x26;amp;Everywhere&#x3C;/hello&#x3E;</lastBuildDate>\n" .
        "\n" .
        "<item>\n",
        "0.9.1 - channel/lastBuildDate Markup Injection"
    );
}

{
    my $rss = create_channel_rss({
        version => "1.0",
        channel_params => 
        [
            dc => 
            {
                date => "</pubDate><hello>There&amp;Everywhere</hello>"
            },
        ],
    });
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<dc:date>&#x3C;/pubDate&#x3E;&#x3C;hello&#x3E;There&#x26;amp;Everywhere&#x3C;/hello&#x3E;</dc:date>\n" .
        "<items>\n",
        "1.0 - dc/date Markup Injection"
    );
}

{
    my $rss = create_channel_rss({version => "2.0", 
            channel_params => [pubDate => "</pubDate><hello>There&amp;Everywhere</hello>"],
            omit_date => 1,
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<pubDate>&#x3C;/pubDate&#x3E;&#x3C;hello&#x3E;There&#x26;amp;Everywhere&#x3C;/hello&#x3E;</pubDate>\n" .
        "\n" .
        "<item>\n",
        "2.0 - channel/pubDate Markup Injection"
    );
}

{
    my $rss = create_channel_rss({version => "2.0", 
            channel_params => [lastBuildDate => "</pubDate><hello>There&amp;Everywhere</hello>"],
            omit_date => 1,
        });
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<lastBuildDate>&#x3C;/pubDate&#x3E;&#x3C;hello&#x3E;There&#x26;amp;Everywhere&#x3C;/hello&#x3E;</lastBuildDate>\n" .
        "\n" .
        "<item>\n",
        "2.0 - channel/lastBuildDate Markup Injection"
    );
}

{
    my $rss = create_rss_with_image_w_undef_link({version => "0.9"});
    # TEST
    contains ($rss, qq{<image>\n<title>freshmeat.net</title>\n<url>0</url>\n</image>\n\n},
        "Image with undefined link does not render the Image - RSS version 0.9"
    );
}


{
    my $rss = create_rss_with_image_w_undef_link({version => "1.0"});
    # TEST
    contains ($rss, 
        qq{<image rdf:about="0">\n<title>freshmeat.net</title>\n} . 
        qq{<url>0</url>\n</image>\n\n},
        "Image with undefined link does not render the Image - RSS version 1.0"
    );
}

{
    my $rss = create_channel_rss({
            version => "1.0", 
            channel_params => [about => "http://xml-rss-hackers.tld/"],
        });
    # TEST
    contains($rss, "<channel rdf:about=\"http://xml-rss-hackers.tld/\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<items>\n",
        "1.0 - channel/about overrides the rdf:about attribute."
    );
}

{
    my $rss = create_channel_rss({
        version => "1.0",
        channel_params => 
        [
            taxo => ["Foo", "Bar", "QuGof", "Lambda&Delta"],
        ],
    });
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        qq{<taxo:topics>\n  <rdf:Bag>\n} .
        qq{    <rdf:li resource="Foo" />\n} .
        qq{    <rdf:li resource="Bar" />\n} .
        qq{    <rdf:li resource="QuGof" />\n} .
        qq{    <rdf:li resource="Lambda&#x26;Delta" />\n} .
        qq{  </rdf:Bag>\n</taxo:topics>\n} .
        "<items>\n",
        "1.0 - taxo topics"
    );
}

{
    my $rss = create_channel_rss({
        version => "1.0",
        channel_params => 
        [
            admin => { 'foobar' => "Quod", },
        ],
    });
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<admin:foobar>Quod</admin:foobar>\n" .
        "<items>\n",
        '1.0 - channel/[module] with unknown key'
    );
}

{
    my $rss = create_channel_rss({
        version => "1.0",
        channel_params => 
        [
            eloq => { 'grow' => "There", },
        ],
    });

    $rss->add_module(prefix => "eloq", uri => "http://eloq.tld2/Gorj/");
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<eloq:grow>There</eloq:grow>\n" .
        "<items>\n",
        '1.0 - channel/[module] with new module'
    );
}

{
    my $rss = create_rss_1({
        version => "1.0",
        image_params => 
        [
            admin => { 'foobar' => "Quod", },
        ],
    });
    # TEST
    contains($rss, "<image rdf:about=\"0\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<url>0</url>\n" .
        "<link>http://freshmeat.net/</link>\n" .
        "<admin:foobar>Quod</admin:foobar>\n" .
        "</image>",
        '1.0 - image/[module] with unknown key'
    );
}

{
    my $rss = create_rss_1({
        version => "1.0",
        image_params => 
        [
            eloq => { 'grow' => "There", },
        ],
    });

    $rss->add_module(prefix => "eloq", uri => "http://eloq.tld2/Gorj/");
    # TEST
    contains($rss, "<image rdf:about=\"0\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<url>0</url>\n" .
        "<link>http://freshmeat.net/</link>\n" .
        "<eloq:grow>There</eloq:grow>\n" .
        "</image>",
        '1.0 - image/[module] with new module'
    );
}

{
    my $rss = create_rss_1({
        version => "1.0",
        image_params => 
        [
            admin => { 'generatorAgent' => "Spozilla 5.5", },
        ],
    });
    # TEST
    contains($rss, "<image rdf:about=\"0\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<url>0</url>\n" .
        "<link>http://freshmeat.net/</link>\n" .
        "<admin:generatorAgent rdf:resource=\"Spozilla 5.5\" />\n" .
        "</image>",
        '1.0 - image/[module] with known module'
    );
}

{
    my $rss = create_channel_rss({
        version => "1.0",
    });

    $rss->add_item(
        title => "In the Jungle",
        link => "http://jungle.tld/Enter/",
        taxo => ["Foo","Loom", "<Ard>", "Yok&Dol"],
    );

    # TEST
    contains($rss, "<item rdf:about=\"http://jungle.tld/Enter/\">\n" .
        "<title>In the Jungle</title>\n" .
        "<link>http://jungle.tld/Enter/</link>\n" .
        qq{<taxo:topics>\n} . 
        qq{  <rdf:Bag>\n} .
        qq{    <rdf:li resource="Foo" />\n} .
        qq{    <rdf:li resource="Loom" />\n} .
        qq{    <rdf:li resource="&#x3C;Ard&#x3E;" />\n} .
        qq{    <rdf:li resource="Yok&#x26;Dol" />\n} .
        qq{  </rdf:Bag>\n} . 
        qq{</taxo:topics>\n} .
        "</item>\n",
        "1.0 - item/taxo:topics (with escaping)"
    );
}

## Test the RSS 1.0 items' ad-hoc modules support.

{
    my $rss = create_item_rss({
        version => "1.0",
        item_params => 
        [
            admin => { 'foobar' => "Quod", },
        ],
    });

    # TEST
    contains($rss, "<item rdf:about=\"http://fc-solve.berlios.de/\">\n" .
        "<title>Freecell Solver</title>\n" .
        "<link>http://fc-solve.berlios.de/</link>\n" .
        "<admin:foobar>Quod</admin:foobar>\n" .
        "</item>",
        '1.0 - item/[module] with unknown key'
    );
}

{
    my $rss = create_item_rss({
        version => "1.0",
        item_params => 
        [
            eloq => { 'grow' => "There", },
        ],
    });

    $rss->add_module(prefix => "eloq", uri => "http://eloq.tld2/Gorj/");

    # TEST
    contains($rss, "<item rdf:about=\"http://fc-solve.berlios.de/\">\n" .
        "<title>Freecell Solver</title>\n" .
        "<link>http://fc-solve.berlios.de/</link>\n" .
        "<eloq:grow>There</eloq:grow>\n" .        
        "</item>",
        '1.0 - item/[module] with new module'
    );
}

{
    my $rss = create_item_rss({
        version => "1.0",
        item_params => 
        [
            admin => { 'generatorAgent' => "Spozilla 5.5", },
        ],
    });

    # TEST
    contains($rss, "<item rdf:about=\"http://fc-solve.berlios.de/\">\n" .
        "<title>Freecell Solver</title>\n" .
        "<link>http://fc-solve.berlios.de/</link>\n" .
        "<admin:generatorAgent rdf:resource=\"Spozilla 5.5\" />\n" .
        "</item>",
        '1.0 - item/[module] with known module'
    );
}

{
    my $rss = create_textinput_with_0_rss({version => "1.0",
            textinput_params => [admin => { 'foobar' => "Quod", },],
        });
    # TEST
    contains(
        $rss,
        ("<textinput rdf:about=\"0\">\n" .
         join("", map {"<$_>0</$_>\n"} (qw(title description name link))) .
         "<admin:foobar>Quod</admin:foobar>\n" .
         "</textinput>\n\n"
        ),
        "1.0 - textinput/[module]",
    );
}

{
    my $rss = create_channel_rss({
        version => "2.0",
        channel_params => 
        [
            admin => { 'generatorAgent' => "Spozilla 5.5", },
        ],
    });

    $rss->add_module(prefix => "admin", uri => "http://webns.net/mvcb/");
    # TEST

    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" .
        "<admin:generatorAgent rdf:resource=\"Spozilla 5.5\" />\n" .
        "\n" . 
        "<item>\n",
        '2.0 - channel/[module] with known module and key'
    );
}


{
    my $rss = create_channel_rss({
        version => "2.0",
        channel_params => 
        [
            admin => { 'foobar' => "Quod", },
        ],
    });
    $rss->add_module(prefix => "admin", uri => "http://webns.net/mvcb/");
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" .
        "<admin:foobar>Quod</admin:foobar>\n" .
        "\n" .
        "<item>\n",
        '2.0 - channel/[module] with unknown key'
    );
}

{
    my $rss = create_channel_rss({
        version => "2.0",
        channel_params => 
        [
            eloq => { 'grow' => "There", },
        ],
    });

    $rss->add_module(prefix => "eloq", uri => "http://eloq.tld2/Gorj/");
    # TEST
    contains($rss, "<channel>\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<lastBuildDate>Sat, 07 Sep 2002 09:42:31 GMT</lastBuildDate>\n" .
        "<eloq:grow>There</eloq:grow>\n" .
        "\n" .
        "<item>\n",
        '2.0 - channel/[module] with new module'
    );
}


## Testing the RSS 2.0 Image Modules Support

{
    my $rss = create_rss_1({
        version => "2.0",
        image_params => 
        [
            admin => { 'foobar' => "Quod", },
        ],
    });
    $rss->add_module(prefix => "admin", uri => "http://webns.net/mvcb/");
    # TEST
    contains($rss, "<image>\n" .
        "<title>freshmeat.net</title>\n" .
        "<url>0</url>\n" .
        "<link>http://freshmeat.net/</link>\n" .
        "<admin:foobar>Quod</admin:foobar>\n" .
        "</image>\n\n",
        '2.0 - image/[module] with unknown key'
    );
}

{
    my $rss = create_rss_1({
        version => "2.0",
        image_params => 
        [
            eloq => { 'grow' => "There", },
        ],
    });

    $rss->add_module(prefix => "eloq", uri => "http://eloq.tld2/Gorj/");
    # TEST
    contains($rss, "<image>\n" .
        "<title>freshmeat.net</title>\n" .
        "<url>0</url>\n" .
        "<link>http://freshmeat.net/</link>\n" .
        "<eloq:grow>There</eloq:grow>\n" .
        "</image>",
        '2.0 - image/[module] with new module'
    );
}

{
    my $rss = create_rss_1({
        version => "2.0",
        image_params => 
        [
            admin => { 'generatorAgent' => "Spozilla 5.5", },
        ],
    });
    $rss->add_module(prefix => "admin", uri => "http://webns.net/mvcb/");
    # TEST
    contains($rss, "<image>\n" .
        "<title>freshmeat.net</title>\n" .
        "<url>0</url>\n" .
        "<link>http://freshmeat.net/</link>\n" .
        "<admin:generatorAgent rdf:resource=\"Spozilla 5.5\" />\n" .
        "</image>",
        '2.0 - image/[module] with known module'
    );
}

## Test the RSS 2.0 items' ad-hoc modules support.

{
    my $rss = create_item_rss({
        version => "2.0",
        item_params => 
        [
            admin => { 'foobar' => "Quod", },
        ],
    });
    $rss->add_module(prefix => "admin", uri => "http://webns.net/mvcb/");

    # TEST
    contains($rss, "<item>\n" .
        "<title>Freecell Solver</title>\n" .
        "<link>http://fc-solve.berlios.de/</link>\n" .
        "<admin:foobar>Quod</admin:foobar>\n" .
        "</item>",
        '2.0 - item/[module] with unknown key'
    );
}

{
    my $rss = create_item_rss({
        version => "2.0",
        item_params => 
        [
            eloq => { 'grow' => "There", },
        ],
    });

    $rss->add_module(prefix => "eloq", uri => "http://eloq.tld2/Gorj/");

    # TEST
    contains($rss, "<item>\n" .
        "<title>Freecell Solver</title>\n" .
        "<link>http://fc-solve.berlios.de/</link>\n" .
        "<eloq:grow>There</eloq:grow>\n" .        
        "</item>",
        '2.0 - item/[module] with new module'
    );
}

{
    my $rss = create_item_rss({
        version => "2.0",
        item_params => 
        [
            admin => { 'generatorAgent' => "Spozilla 5.5", },
        ],
    });
    $rss->add_module(prefix => "admin", uri => "http://webns.net/mvcb/");

    # TEST
    contains($rss, "<item>\n" .
        "<title>Freecell Solver</title>\n" .
        "<link>http://fc-solve.berlios.de/</link>\n" .
        "<admin:generatorAgent rdf:resource=\"Spozilla 5.5\" />\n" .
        "</item>",
        '2.0 - item/[module] with known module'
    );
}

## Test the RSS 2.0 skipping-items condition.

{
    my $rss = create_rss_without_item({
        version => "2.0",
    });
    $rss->add_item(
        link  => "http://freshmeat.net/news/1999/06/21/930003829.html"
    );

    # TEST
    not_contains($rss, "<item>\n" .
        '2.0 - Item without description or title is skipped'
    );
}

## Test the RSS 2.0 <source url= condition.
{
    # TEST:$num_iters=3;
    foreach my $s (
        [undef, "http://www.hercules.tld/",],
        ["Hercules", undef,],
        [undef, undef],
        )
    {
        my $rss = create_item_with_0_rss({version => "2.0",
                item_params => 
                [
                    title => "Foo&Bar",
                    link => "http://www.mylongtldyeahbaby/",
                    source => $s->[0],
                    sourceUrl => $s->[1],
                ],
            }
        );

        # TEST*$num_iters
        contains(
            $rss,
            ("<item>\n" .
             "<title>Foo&#x26;Bar</title>\n" .
             "<link>http://www.mylongtldyeahbaby/</link>\n" .
             "</item>"
             ),
            "2.0 - item - Source and/or Source URL are not defined",
        );
    }
}

{
    # Here we create an RSS 2.0 object and render it as the output
    # version "3.5" in order to test that version 1.0 is the default
    # version for output.
    my $rss = create_channel_rss({
            version => "2.0", 
            channel_params =>
            [copyright => "Martha", managingEditor => 0,],
            omit_date => 1,
        });
    $rss->{output} = "3.5";
    # TEST
    contains($rss, "<channel rdf:about=\"http://freshmeat.net\">\n" .
        "<title>freshmeat.net</title>\n" .
        "<link>http://freshmeat.net</link>\n" .
        "<description>Linux software</description>\n" .
        "<dc:rights>Martha</dc:rights>\n" .
        "<dc:publisher>0</dc:publisher>\n" .
        "<items>\n",
        "Unknown version renders as 1.0"
    );
}

################
### RSS Parsing Tests:
### We generate RSS and test that we get the same results.
################

sub parse_generated_rss
{
    my $args = shift;

    my $gen_func = $args->{'func'};

    my $rss_generator = $gen_func->($args);

    $rss_generator->{output} = $args->{version};

    my $output = $rss_generator->as_string();
    
    if ($args->{postproc})
    {
        $args->{postproc}->(\$output);
    }
    
    my $parser = XML::RSS->new(version => $args->{version});

    $parser->parse($output);

    return $parser;
}

{
    my $rss =
        parse_generated_rss({
            func => \&create_textinput_with_0_rss,
            version => "0.9",
            textinput_params => [
                description => "Welcome to the Jungle.", 
                'link' => "http://fooque.tld/",
                'title' => "The Jungle of the City",
                'name' => "There's more than one way to do it.",
                ],
            postproc => sub {
                    for (${shift()})
                    {
                        s{(<rdf:RDF)[^>]*(>)}{<rss version="0.9">};
                        s{</rdf:RDF>}{</rss>};
                    }
            },
        });

    # TEST
    is ($rss->{textinput}->{description},
        "Welcome to the Jungle.",
        "0.9 parse - textinput/description",
    );

    # TEST
    is ($rss->{textinput}->{link},
        "http://fooque.tld/",
        "0.9 parse - textinput/link",
    );

    # TEST
    is ($rss->{textinput}->{title},
        "The Jungle of the City",
        "0.9 parse - textinput/title",
    );

    # TEST
    is ($rss->{textinput}->{name},
        "There's more than one way to do it.",
        "0.9 parse - textinput/name",
    );
}

{
    my $rss_parser =
        parse_generated_rss(
            {
                func => \&create_textinput_with_0_rss,
                version => "0.9",
                textinput_params => [
                    description => "Welcome to the Jungle.", 
                    'link' => "http://fooque.tld/",
                    'title' => "The Jungle of the City",
                    'name' => "There's more than one way to do it.",
                ],
                postproc => sub {
                    for (${shift()})
                    {
                        s{(<rdf:RDF)[^>]*(>)}{<rss version="0.9">};
                        s{</rdf:RDF>}{</rss>};
                        s{<(/?)textinput>}{<$1textInput>}g;
                    }   
                },
            }
        );

    # TEST
    is ($rss_parser->{textinput}->{description},
        "Welcome to the Jungle.",
        "0.9 parse - textinput/description",
    );

    # TEST
    is ($rss_parser->{textinput}->{link},
        "http://fooque.tld/",
        "Parse textInput (with capital I) - textinput/link",
    );

    # TEST
    is ($rss_parser->{textinput}->{title},
        "The Jungle of the City",
        "Parse textInput (with capital I) - textinput/title",
    );

    # TEST
    is ($rss_parser->{textinput}->{name},
        "There's more than one way to do it.",
        "Parse textInput (with capital I) - textinput/name",
    );
}

{
    my $rss_parser =
        parse_generated_rss(
            {
                func => \&create_textinput_with_0_rss,
                version => "0.9",
                textinput_params => [
                    description => "Welcome to the Jungle.", 
                    'link' => "http://fooque.tld/",
                    'title' => "The Jungle of the City",
                    'name' => "There's more than one way to do it.",
                ],
                postproc => sub {
                    for (${shift()})
                    {
                        s{<(/?)textinput>}{<$1textInput>}g
                    }
                },
            }
        );

    # TEST
    is ($rss_parser->{textinput}->{description},
        "Welcome to the Jungle.",
        "0.9 parse - textinput/description",
    );

    # TEST
    is ($rss_parser->{textinput}->{link},
        "http://fooque.tld/",
        "Parse textInput (with capital I) - textinput/link",
    );

    # TEST
    is ($rss_parser->{textinput}->{title},
        "The Jungle of the City",
        "Parse textInput (with capital I) - textinput/title",
    );

    # TEST
    is ($rss_parser->{textinput}->{name},
        "There's more than one way to do it.",
        "Parse textInput (with capital I) - textinput/name",
    )
}

{
    my $rss_parser =
        parse_generated_rss(
            {
                func => \&create_skipHours_rss,
                version => "0.91", 
                skipHours_params => [ hour => "5" ],
            }
        );

    # TEST
    is ($rss_parser->{skipHours}->{hour},
        "5",
        "Parse 0.91 - skipHours/hour",
    );
}

{
    my $rss_parser =
        parse_generated_rss(
            {
                func => \&create_skipHours_rss,
                version => "2.0", 
                skipHours_params => [ hour => "5" ],
            }
        );
    
    # TEST
    is ($rss_parser->{skipHours}->{hour},
        "5",
        "Parse 2.0 - skipHours/hour",
    );
}

## Test the skipDays parsing.

{
    my $rss_parser =
        parse_generated_rss(
            {
                func => \&create_skipDays_rss,
                version => "0.91", 
                skipDays_params => [ day => "5" ],
            }
        );

    # TEST
    is ($rss_parser->{skipDays}->{day},
        "5",
        "Parse 0.91 - skipDays/day",
    );
}

{
    my $rss_parser =
        parse_generated_rss(
            {
                func => \&create_skipDays_rss,
                version => "2.0", 
                skipDays_params => [ day => "5" ],
            }
        );
    
    # TEST
    is ($rss_parser->{skipDays}->{day},
        "5",
        "Parse 2.0 - skipDays/day",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "2.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rss version="2.0"
 xmlns:blogChannel="http://backend.userland.com/blogChannelModule"
 xmlns:foo="http://foo.tld/foobar/"
>

<channel>
<title>Test 2.0 Feed</title>
<link>http://example.com/</link>
<description></description>
<language>en-us</language>
<copyright>Copyright 2002</copyright>
<pubDate>2007-01-19T14:21:43+0200</pubDate>
<lastBuildDate>2007-01-19T14:21:43+0200</lastBuildDate>
<docs>http://backend.userland.com/rss</docs>
<managingEditor>editor@example.com</managingEditor>
<webMaster>webmaster@example.com</webMaster>
<category>MyCategory</category>
<generator>XML::RSS Test</generator>
<ttl>60</ttl>

<image>
<title>Test Image</title>
<url>http://example.com/example.gif</url>
<link>http://example.com/</link>
<height>25</height>
<description>Test Image</description>
<foo:hello>Hi there!</foo:hello>
</image>

<item>
<title>This is an item</title>
<link>http://example.com/2007/01/19</link>
<description>Yadda yadda yadda - R&#x26;D;</description>
<author>joeuser@example.com</author>
<category>MyCategory</category>
<comments>http://example.com/2007/01/19/comments.html</comments>
<guid isPermaLink="true">http://example.com/2007/01/19</guid>
<pubDate>Fri 19 Jan 2007 02:21:43 PM IST GMT</pubDate>
<source url="http://example.com">my brain</source>
<enclosure url="http://127.0.0.1/torrents/The_Passion_of_Dave_Winer.torrent" type="application/x-bittorrent" />
</item>

</channel>
</rss>
EOF

    # TEST
    is ($rss_parser->{image}->{"http://foo.tld/foobar/"}->{hello},
        "Hi there!",
        "Parsing 2.0 - element in a different namespace contained in image",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "1.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns="http://purl.org/rss/1.0/"
 xmlns:content="http://purl.org/rss/1.0/modules/content/"
 xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:syn="http://purl.org/rss/1.0/modules/syndication/"
 xmlns:my="http://purl.org/my/rss/module/"
 xmlns:admin="http://webns.net/mvcb/"
>

<channel rdf:about="http://example.com/">
<title>Test 1.0 Feed</title>
<link>http://example.com/</link>
<description>To lead by example</description>
<dc:date>2007-01-19T14:21:18+0200</dc:date>
<items>
 <rdf:Seq>
  <rdf:li rdf:resource="http://example.com/2007/01/19" />
 </rdf:Seq>
</items>
<image rdf:resource="http://example.com/example.gif" />
<textinput rdf:resource="http://example.com/search.pl" />
</channel>

<image rdf:about="http://example.com/example.gif" xmlns="">
<title>Test Image</title>
<url>http://example.com/example.gif</url>
<link>http://example.com/</link>
<foo>Aye Karamba</foo>
</image>

<item rdf:about="http://example.com/2007/01/19">
<title>This is an item</title>
<link>http://example.com/2007/01/19</link>
<description>Yadda &#x26; yadda &#x26; yadda</description>
<dc:creator>joeuser@example.com</dc:creator>
</item>

<textinput rdf:about="http://example.com/search.pl">
<title>Search</title>
<description>Search for an example</description>
<name>q</name>
<link>http://example.com/search.pl</link>
</textinput>

</rdf:RDF>
EOF

    # TEST
    is ($rss_parser->{image}->{""}->{foo},
        "Aye Karamba",
        "Parsing 1.0 - element in a null namespace contained in image",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "2.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rss version="2.0"
 xmlns:blogChannel="http://backend.userland.com/blogChannelModule"
 xmlns:foo="http://foo.tld/foobar/"
>

<channel>
<title>Test 2.0 Feed</title>
<link>http://example.com/</link>
<description></description>
<language>en-us</language>
<copyright>Copyright 2002</copyright>
<pubDate>2007-01-19T14:21:43+0200</pubDate>
<lastBuildDate>2007-01-19T14:21:43+0200</lastBuildDate>
<docs>http://backend.userland.com/rss</docs>
<managingEditor>editor@example.com</managingEditor>
<webMaster>webmaster@example.com</webMaster>
<category>MyCategory</category>
<generator>XML::RSS Test</generator>
<ttl>60</ttl>

<image>
<title>Test Image</title>
<url>http://example.com/example.gif</url>
<link>http://example.com/</link>
<height>25</height>
<description>Test Image</description>
</image>

<item>
<title>This is an item</title>
<link>http://example.com/2007/01/19</link>
<description>Yadda yadda yadda - R&#x26;D;</description>
<author>joeuser@example.com</author>
<category>MyCategory</category>
<comments>http://example.com/2007/01/19/comments.html</comments>
<guid isPermaLink="true">http://example.com/2007/01/19</guid>
<pubDate>Fri 19 Jan 2007 02:21:43 PM IST GMT</pubDate>
<source url="http://example.com">my brain</source>
<enclosure url="http://127.0.0.1/torrents/The_Passion_of_Dave_Winer.torrent" type="application/x-bittorrent" />
<foo:hello>Hi there!</foo:hello>
</item>

</channel>
</rss>
EOF

    # TEST
    is ($rss_parser->{items}->[0]->{"http://foo.tld/foobar/"}->{hello},
        "Hi there!",
        "Parsing 2.0 - element in a different namespace contained in an item",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "1.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns="http://purl.org/rss/1.0/"
 xmlns:alterrss="http://purl.org/rss/1.0/"
 xmlns:content="http://purl.org/rss/1.0/modules/content/"
 xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:syn="http://purl.org/rss/1.0/modules/syndication/"
 xmlns:my="http://purl.org/my/rss/module/"
 xmlns:admin="http://webns.net/mvcb/"
>

<channel rdf:about="http://example.com/">
<title>Test 1.0 Feed</title>
<link>http://example.com/</link>
<description>To lead by example</description>
<dc:date>2007-01-19T14:21:18+0200</dc:date>
<items>
 <rdf:Seq>
  <rdf:li rdf:resource="http://example.com/2007/01/19" />
 </rdf:Seq>
</items>
<image rdf:resource="http://example.com/example.gif" />
<textinput rdf:resource="http://example.com/search.pl" />
</channel>

<image rdf:about="http://example.com/example.gif">
<title>Test Image</title>
<url>http://example.com/example.gif</url>
<link>http://example.com/</link>
</image>

<alterrss:item rdf:about="http://example.com/2007/01/19" xmlns="">
<title>This is an item</title>
<link>http://example.com/2007/01/19</link>
<description>Yadda &#x26; yadda &#x26; yadda</description>
<dc:creator>joeuser@example.com</dc:creator>
<foo>Aye Karamba</foo>
</alterrss:item>

<textinput rdf:about="http://example.com/search.pl">
<title>Search</title>
<description>Search for an example</description>
<name>q</name>
<link>http://example.com/search.pl</link>
</textinput>

</rdf:RDF>
EOF

    # TEST
    is ($rss_parser->{items}->[0]->{""}->{foo},
        "Aye Karamba",
        "Parsing 1.0 - element in a null namespace contained in image",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "2.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rss version="2.0"
 xmlns:blogChannel="http://backend.userland.com/blogChannelModule"
 xmlns:foo="http://foo.tld/foobar/"
>

<channel>
<title>Test 2.0 Feed</title>
<link>http://example.com/</link>
<description></description>
<language>en-us</language>
<copyright>Copyright 2002</copyright>
<pubDate>2007-01-19T14:21:43+0200</pubDate>
<lastBuildDate>2007-01-19T14:21:43+0200</lastBuildDate>
<docs>http://backend.userland.com/rss</docs>
<managingEditor>editor@example.com</managingEditor>
<webMaster>webmaster@example.com</webMaster>
<category>MyCategory</category>
<generator>XML::RSS Test</generator>
<ttl>60</ttl>

<image>
<title>Test Image</title>
<url>http://example.com/example.gif</url>
<link>http://example.com/</link>
<height>25</height>
<description>Test Image</description>
</image>

<item>
<title>This is an item</title>
<link>http://example.com/2007/01/19</link>
<description>Yadda yadda yadda - R&#x26;D;</description>
<author>joeuser@example.com</author>
<category>MyCategory</category>
<comments>http://example.com/2007/01/19/comments.html</comments>
<guid isPermaLink="true">http://example.com/2007/01/19</guid>
<pubDate>Fri 19 Jan 2007 02:21:43 PM IST GMT</pubDate>
<source url="http://example.com">my brain</source>
<enclosure url="http://127.0.0.1/torrents/The_Passion_of_Dave_Winer.torrent" type="application/x-bittorrent" />
</item>

<textInput>
<title>Search</title>
<description>Search for an example</description>
<name>q</name>
<link>http://example.com/search.pl</link>
<foo:hello>Show Baloon</foo:hello>
</textInput>

</channel>
</rss>
EOF

    # TEST
    is ($rss_parser->{textinput}->{"http://foo.tld/foobar/"}->{hello},
        "Show Baloon",
        "Parsing 2.0 - element in a different namespace contained in a textinput",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "1.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns="http://purl.org/rss/1.0/"
 xmlns:alterrss="http://purl.org/rss/1.0/"
 xmlns:content="http://purl.org/rss/1.0/modules/content/"
 xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:syn="http://purl.org/rss/1.0/modules/syndication/"
 xmlns:my="http://purl.org/my/rss/module/"
 xmlns:admin="http://webns.net/mvcb/"
>

<channel rdf:about="http://example.com/">
<title>Test 1.0 Feed</title>
<link>http://example.com/</link>
<description>To lead by example</description>
<dc:date>2007-01-19T14:21:18+0200</dc:date>
<items>
 <rdf:Seq>
  <rdf:li rdf:resource="http://example.com/2007/01/19" />
 </rdf:Seq>
</items>
<image rdf:resource="http://example.com/example.gif" />
<textinput rdf:resource="http://example.com/search.pl" />
</channel>

<image rdf:about="http://example.com/example.gif">
<title>Test Image</title>
<url>http://example.com/example.gif</url>
<link>http://example.com/</link>
</image>

<item rdf:about="http://example.com/2007/01/19">
<title>This is an item</title>
<link>http://example.com/2007/01/19</link>
<description>Yadda &#x26; yadda &#x26; yadda</description>
<dc:creator>joeuser@example.com</dc:creator>
</item>

<textinput rdf:about="http://example.com/search.pl" xmlns="">
<title>Search</title>
<description>Search for an example</description>
<name>q</name>
<link>http://example.com/search.pl</link>
<foo>Priceless</foo>
</textinput>

</rdf:RDF>
EOF

    # TEST
    is ($rss_parser->{textinput}->{""}->{foo},
        "Priceless",
        "Parsing 1.0 - element in a null namespace contained in a textinput",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "2.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rss version="2.0"
 xmlns:blogChannel="http://backend.userland.com/blogChannelModule"
 xmlns:foo="http://foo.tld/foobar/"
>

<channel>
<title>Test 2.0 Feed</title>
<link>http://example.com/</link>
<description></description>
<language>en-us</language>
<copyright>Copyright 2002</copyright>
<pubDate>2007-01-19T14:21:43+0200</pubDate>
<lastBuildDate>2007-01-19T14:21:43+0200</lastBuildDate>
<docs>http://backend.userland.com/rss</docs>
<managingEditor>editor@example.com</managingEditor>
<webMaster>webmaster@example.com</webMaster>
<category>MyCategory</category>
<generator>XML::RSS Test</generator>
<ttl>60</ttl>
<foo:hello>The RSS Must Flow</foo:hello>

<image>
<title>Test Image</title>
<url>http://example.com/example.gif</url>
<link>http://example.com/</link>
<height>25</height>
<description>Test Image</description>
</image>

<item>
<title>This is an item</title>
<link>http://example.com/2007/01/19</link>
<description>Yadda yadda yadda - R&#x26;D;</description>
<author>joeuser@example.com</author>
<category>MyCategory</category>
<comments>http://example.com/2007/01/19/comments.html</comments>
<guid isPermaLink="true">http://example.com/2007/01/19</guid>
<pubDate>Fri 19 Jan 2007 02:21:43 PM IST GMT</pubDate>
<source url="http://example.com">my brain</source>
<enclosure url="http://127.0.0.1/torrents/The_Passion_of_Dave_Winer.torrent" type="application/x-bittorrent" />
</item>

<textInput>
<title>Search</title>
<description>Search for an example</description>
<name>q</name>
<link>http://example.com/search.pl</link>
</textInput>

</channel>
</rss>
EOF

    # TEST
    is ($rss_parser->{channel}->{"http://foo.tld/foobar/"}->{hello},
        "The RSS Must Flow",
        "Parsing 2.0 - element in a different namespace contained in a channel",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "1.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns="http://purl.org/rss/1.0/"
 xmlns:alterrss="http://purl.org/rss/1.0/"
 xmlns:content="http://purl.org/rss/1.0/modules/content/"
 xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:syn="http://purl.org/rss/1.0/modules/syndication/"
 xmlns:my="http://purl.org/my/rss/module/"
 xmlns:admin="http://webns.net/mvcb/"
>

<channel rdf:about="http://example.com/" xmlns="">
<title>Test 1.0 Feed</title>
<link>http://example.com/</link>
<description>To lead by example</description>
<dc:date>2007-01-19T14:21:18+0200</dc:date>
<items>
 <rdf:Seq>
  <rdf:li rdf:resource="http://example.com/2007/01/19" />
 </rdf:Seq>
</items>
<image rdf:resource="http://example.com/example.gif" />
<textinput rdf:resource="http://example.com/search.pl" />
<foo>Placebo is here</foo>
</channel>

<image rdf:about="http://example.com/example.gif">
<title>Test Image</title>
<url>http://example.com/example.gif</url>
<link>http://example.com/</link>
</image>

<item rdf:about="http://example.com/2007/01/19">
<title>This is an item</title>
<link>http://example.com/2007/01/19</link>
<description>Yadda &#x26; yadda &#x26; yadda</description>
<dc:creator>joeuser@example.com</dc:creator>
</item>

<textinput rdf:about="http://example.com/search.pl">
<title>Search</title>
<description>Search for an example</description>
<name>q</name>
<link>http://example.com/search.pl</link>
</textinput>

</rdf:RDF>
EOF

    # TEST
    is ($rss_parser->{channel}->{""}->{foo},
        "Placebo is here",
        "Parsing 1.0 - element in a null namespace contained in a channel",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "1.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns="http://purl.org/rss/1.0/"
 xmlns:content="http://purl.org/rss/1.0/modules/content/"
 xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:syn="http://purl.org/rss/1.0/modules/syndication/"
 xmlns:admin="http://webns.net/mvcb/"
>

<channel rdf:about="http://freshmeat.net">
<title>freshmeat.net</title>
<link>http://freshmeat.net</link>
<description>Linux software</description>
<items>
 <rdf:Seq>
  <rdf:li rdf:resource="http://freshmeat.net/news/1999/06/21/930003829.html" />
  <rdf:li rdf:resource="http://jungle.tld/Enter/" />
 </rdf:Seq>
</items>
</channel>

<item rdf:about="http://freshmeat.net/news/1999/06/21/930003829.html">
<title>GTKeyboard 0.85</title>
<link>http://freshmeat.net/news/1999/06/21/930003829.html</link>
</item>

<item rdf:about="http://jungle.tld/Enter/">
<title>In the Jungle</title>
<link>http://jungle.tld/Enter/</link>
<taxo:topics>
  <rdf:Bag>
    <rdf:li resource="Foo" />
    <rdf:li resource="Loom" />
    <rdf:li resource="Hello" />
    <rdf:li resource="myowA" />
  </rdf:Bag>
</taxo:topics>
</item>

</rdf:RDF>
EOF

    # TEST
    is_deeply ($rss_parser->{items}->[1]->{taxo},
        ["Foo", "Loom", "Hello", "myowA"],
        "Parsing 1.0 - taxo items",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "1.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns="http://purl.org/rss/1.0/"
 xmlns:content="http://purl.org/rss/1.0/modules/content/"
 xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:syn="http://purl.org/rss/1.0/modules/syndication/"
 xmlns:admin="http://webns.net/mvcb/"
>

<channel rdf:about="http://freshmeat.net">
<title>freshmeat.net</title>
<link>http://freshmeat.net</link>
<description>Linux software</description>
<items>
 <rdf:Seq>
  <rdf:li rdf:resource="http://freshmeat.net/news/1999/06/21/930003829.html" />
  <rdf:li rdf:resource="http://jungle.tld/Enter/" />
 </rdf:Seq>
</items>
</channel>

<item rdf:about="http://freshmeat.net/news/1999/06/21/930003829.html">
<title>GTKeyboard 0.85</title>
<link>http://freshmeat.net/news/1999/06/21/930003829.html</link>
</item>

<item rdf:about="http://jungle.tld/Enter/">
<title>In the Jungle</title>
<link>http://jungle.tld/Enter/</link>
<taxo:topics>
  <rdf:Bag>
    <rdf:li resource="Everybody" />
    <rdf:li resource="needs" />
    <dc:hello />
    <rdf:li resource="a" />
    <rdf:li resource="[[[HUG]]]" />
  </rdf:Bag>
</taxo:topics>
</item>

</rdf:RDF>
EOF

    # TEST
    is_deeply ($rss_parser->{items}->[1]->{taxo},
        ["Everybody", "needs", "a", "[[[HUG]]]"],
        "Parsing 1.0 - taxo bag in <item> with junk elements",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "1.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns="http://purl.org/rss/1.0/"
 xmlns:content="http://purl.org/rss/1.0/modules/content/"
 xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:syn="http://purl.org/rss/1.0/modules/syndication/"
 xmlns:admin="http://webns.net/mvcb/"
>

<channel rdf:about="http://freshmeat.net">
<title>freshmeat.net</title>
<link>http://freshmeat.net</link>
<description>Linux software</description>
<items>
 <rdf:Seq>
  <rdf:li rdf:resource="http://freshmeat.net/news/1999/06/21/930003829.html" />
  <rdf:li rdf:resource="http://jungle.tld/Enter/" />
 </rdf:Seq>
</items>
<taxo:topics>
  <rdf:Bag>
    <rdf:li resource="Elastic" />
    <rdf:li resource="Plastic" />
    <rdf:li resource="stochastic" />
    <rdf:li resource="dynamic^^K" />
  </rdf:Bag>
</taxo:topics>
</channel>

<item rdf:about="http://freshmeat.net/news/1999/06/21/930003829.html">
<title>GTKeyboard 0.85</title>
<link>http://freshmeat.net/news/1999/06/21/930003829.html</link>
</item>

<item rdf:about="http://jungle.tld/Enter/">
<title>In the Jungle</title>
<link>http://jungle.tld/Enter/</link>
<taxo:topics>
  <rdf:Bag>
    <rdf:li resource="Foo" />
    <rdf:li resource="Loom" />
    <rdf:li resource="Hello" />
    <rdf:li resource="myowA" />
  </rdf:Bag>
</taxo:topics>
</item>

</rdf:RDF>
EOF

    # TEST
    is_deeply ($rss_parser->{channel}->{taxo},
        ["Elastic", "Plastic", "stochastic", "dynamic^^K"],
        "Parsing 1.0 - taxo items in channel",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "1.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns="http://purl.org/rss/1.0/"
 xmlns:content="http://purl.org/rss/1.0/modules/content/"
 xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:syn="http://purl.org/rss/1.0/modules/syndication/"
 xmlns:admin="http://webns.net/mvcb/"
>

<channel rdf:about="http://freshmeat.net">
<title>freshmeat.net</title>
<link>http://freshmeat.net</link>
<description>Linux software</description>
<items>
 <rdf:Seq>
  <rdf:li rdf:resource="http://freshmeat.net/news/1999/06/21/930003829.html" />
  <rdf:li rdf:resource="http://jungle.tld/Enter/" />
 </rdf:Seq>
</items>
<taxo:topics>
  <rdf:Bag>
    <rdf:li resource="Elastic" />
    <rdf:li resource="Plastic" />
    <rdf:li resource="stochastic" />
    <dc:hello />
    <rdf:li resource="dynamic^^K" />
  </rdf:Bag>
</taxo:topics>
</channel>

<item rdf:about="http://freshmeat.net/news/1999/06/21/930003829.html">
<title>GTKeyboard 0.85</title>
<link>http://freshmeat.net/news/1999/06/21/930003829.html</link>
</item>

<item rdf:about="http://jungle.tld/Enter/">
<title>In the Jungle</title>
<link>http://jungle.tld/Enter/</link>
<taxo:topics>
  <rdf:Bag>
    <rdf:li resource="Foo" />
    <rdf:li resource="Loom" />
    <rdf:li resource="Hello" />
    <rdf:li resource="myowA" />
  </rdf:Bag>
</taxo:topics>
</item>

</rdf:RDF>
EOF

    # TEST
    is_deeply ($rss_parser->{channel}->{taxo},
        ["Elastic", "Plastic", "stochastic", "dynamic^^K"],
        "Parsing 1.0 - taxo items in channel with junk items",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "1.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns="http://purl.org/rss/1.0/"
 xmlns:content="http://purl.org/rss/1.0/modules/content/"
 xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:syn="http://purl.org/rss/1.0/modules/syndication/"
 xmlns:admin="http://webns.net/mvcb/"
>

<channel rdf:about="http://freshmeat.net">
<title>freshmeat.net</title>
<link>http://freshmeat.net</link>
<description>Linux software</description>
<items>
 <rdf:Seq>
  <rdf:li rdf:resource="http://freshmeat.net/news/1999/06/21/930003829.html" />
  <rdf:li rdf:resource="http://jungle.tld/Enter/" />
 </rdf:Seq>
</items>
<taxo:topics>
  <rdf:Bag>
    <rdf:li resource="Elastic" />
    <rdf:li resource="Plastic" />
    <rdf:li resource="stochastic" />
    <dc:hello />
    <rdf:li resource="dynamic^^K" />
  </rdf:Bag>
</taxo:topics>
</channel>

<item rdf:about="http://freshmeat.net/news/1999/06/21/930003829.html">
<title>GTKeyboard 0.85</title>
<link>http://freshmeat.net/news/1999/06/21/930003829.html</link>
</item>

<item rdf:about="http://jungle.tld/Enter/">
<title>In the Jungle</title>
<link>http://jungle.tld/Enter/</link>
<admin:hello>Gow</admin:hello>
</item>

</rdf:RDF>
EOF

    # TEST
    is ($rss_parser->{items}->[1]->{"http://webns.net/mvcb/"}->{hello},
        "Gow",
        "Parsing 1.0 - Elements inside <item> that don't exist in \%rdf_resource_fields",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "1.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns="http://purl.org/rss/1.0/"
 xmlns:content="http://purl.org/rss/1.0/modules/content/"
 xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:syn="http://purl.org/rss/1.0/modules/syndication/"
 xmlns:admin="http://webns.net/mvcb/"
>

<channel rdf:about="http://freshmeat.net">
<title>freshmeat.net</title>
<link>http://freshmeat.net</link>
<description>Linux software</description>
<items>
 <rdf:Seq>
  <rdf:li rdf:resource="http://freshmeat.net/news/1999/06/21/930003829.html" />
  <rdf:li rdf:resource="http://jungle.tld/Enter/" />
 </rdf:Seq>
</items>
<taxo:topics>
  <rdf:Bag>
    <rdf:li resource="Elastic" />
    <rdf:li resource="Plastic" />
    <rdf:li resource="stochastic" />
    <dc:hello />
    <rdf:li resource="dynamic^^K" />
  </rdf:Bag>
</taxo:topics>
</channel>

<admin:generatorAgent>Gow</admin:generatorAgent>
<item rdf:about="http://freshmeat.net/news/1999/06/21/930003829.html">
<title>GTKeyboard 0.85</title>
<link>http://freshmeat.net/news/1999/06/21/930003829.html</link>
</item>

<item rdf:about="http://jungle.tld/Enter/">
<title>In the Jungle</title>
<link>http://jungle.tld/Enter/</link>
</item>

</rdf:RDF>
EOF

    # TEST
    ok ((!grep { exists($_->{"http://webns.net/mvcb/"}->{generatorAgent}) }
        @{$rss_parser->{items}}),
        "Parsing 1.0 - Elements that exist in \%rdf_resource_fields but not inside item",
    );
}

{
    my $rss_parser = XML::RSS->new(version => "1.0");

    $rss_parser->parse(<<'EOF');
<?xml version="1.0" encoding="UTF-8"?>

<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns="http://purl.org/rss/1.0/"
 xmlns:content="http://purl.org/rss/1.0/modules/content/"
 xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:syn="http://purl.org/rss/1.0/modules/syndication/"
 xmlns:admin="http://webns.net/mvcb/"
>

<channel rdf:about="http://freshmeat.net">
<title>freshmeat.net</title>
<link>http://freshmeat.net</link>
<description>Linux software</description>
<items>
 <rdf:Seq>
  <rdf:li rdf:resource="http://freshmeat.net/news/1999/06/21/930003829.html" />
  <rdf:li rdf:resource="http://jungle.tld/Enter/" />
 </rdf:Seq>
</items>
<taxo:topics>
  <rdf:Bag>
    <rdf:li resource="Elastic" />
    <rdf:li resource="Plastic" />
    <rdf:li resource="stochastic" />
    <dc:hello />
    <rdf:li resource="dynamic^^K" />
  </rdf:Bag>
</taxo:topics>
</channel>

<item rdf:about="http://freshmeat.net/news/1999/06/21/930003829.html">
<title>GTKeyboard 0.85</title>
<link>http://freshmeat.net/news/1999/06/21/930003829.html</link>
</item>

<item rdf:about="http://jungle.tld/Enter/">
<title>In the Jungle</title>
<link>http://jungle.tld/Enter/</link>
</item>
<enclosure foo="bar" good="them" />

</rdf:RDF>
EOF

    # TEST
    ok ((!grep { exists($_->{enclosure}) }
        @{$rss_parser->{items}}),
        "Parsing 1.0 - Testing \%empty_ok_elements",
    );
}

