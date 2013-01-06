return {

    type    = "configuration",
    version = "1.0.2",
    date    = "2010-06-07",
    time    = "14:49:00",
    comment = "ConTeXt MkIV configuration file",
    author  = "Hans Hagen, PRAGMA-ADE, Hasselt NL",

    content = {

     -- LUACSTRIP       = 'f',
     -- PURGECACHE      = 't',

        TEXMFCACHE      = "~/.context-minimals/texmf-cache",
	-- $SELFAUTOPARENT/texmf-cache",

        TEXMFOS         = "$SELFAUTODIR",
        TEXMFMAIN       = "$SELFAUTOPARENT/texmf",
        TEXMFCONTEXT    = "$SELFAUTOPARENT/texmf-context",
        TEXMFLOCAL      = "$SELFAUTOPARENT/texmf-local",
        TEXMFFONTS      = "$SELFAUTOPARENT/texmf-fonts",
        TEXMFEXTRA      = "$SELFAUTOPARENT/texmf-extra",
        TEXMFPROJECT    = "$SELFAUTOPARENT/texmf-project",

        TEXMFHOME       = "~/texmf-home", -- "tree:///~/texmf

        TEXMF           = "{$TEXMFHOME,!!$TEXMFPROJECT,!!$TEXMFFONTS,!!$TEXMFLOCAL,!!$TEXMFCONTEXT,!!$TEXMFOS,!!$TEXMFEXTRA,!!$TEXMFMAIN}",

        TEXFONTMAPS     = ".;$TEXMF/fonts/{data,map}/{pdftex,dvips,}//",
    --  ENCFONTS        = ".;$TEXMF/{fonts/{data,enc},dvips,pdftex,dvipdfm}//",
        ENCFONTS        = ".;$TEXMF/fonts/{data,enc}/{dvips,pdftex}//",
        VFFONTS         = ".;$TEXMF/fonts/{data,vf}//",
        TFMFONTS        = ".;$TEXMF/fonts/{data,tfm}//",
        T1FONTS         = ".;$TEXMF/fonts/{data,type1,pfb}//;$OSFONTDIR",
        AFMFONTS        = ".;$TEXMF/fonts/{data,afm}//;$OSFONTDIR",
        TTFONTS         = ".;$TEXMF/fonts/{data,truetype,ttf}//;$OSFONTDIR",
        OPENTYPEFONTS   = ".;$TEXMF/fonts/{data,opentype}//;$OSFONTDIR",
        CMAPFONTS       = ".;$TEXMF/fonts/cmap//",
        FONTFEATURES    = ".;$TEXMF/fonts/{data,fea}//;$OPENTYPEFONTS;$TTFONTS;$T1FONTS;$AFMFONTS",
        FONTCIDMAPS     = ".;$TEXMF/fonts/{data,cid}//;$OPENTYPEFONTS;$TTFONTS;$T1FONTS;$AFMFONTS",
        OFMFONTS        = ".;$TEXMF/fonts/{data,ofm,tfm}//",
        OVFFONTS        = ".;$TEXMF/fonts/{data,ovf,vf}//",

        TEXINPUTS       = ".;{$TXRESOURCES}//;{$CTXDEVTXPATH};$TEXMF/tex/{context,plain/base,generic}//",
        MPINPUTS        = ".;{$MFRESOURCES}//;{$CTXDEVMPPATH};$TEXMF/metapost/{context,base,}//",

        -- In the next variable the inputs path will go away.

        TEXMFSCRIPTS    = ".;$CTXDEVLUPATH;$CTXDEVRBPATH;$CTXDEVPLPATH;$TEXMF/scripts/context/{lua,ruby,python,perl}//;$TEXINPUTS",
        PERLINPUTS      = ".;$CTXDEVPLPATH;$TEXMF/scripts/context/perl",
        PYTHONINPUTS    = ".;$CTXDEVPYPATH;$TEXMF/scripts/context/python",
        RUBYINPUTS      = ".;$CTXDEVRBPATH;$TEXMF/scripts/context/ruby",
        LUAINPUTS       = ".;$CTXDEVLUPATH;$TEXINPUTS;$TEXMF/scripts/context/lua//",
        CLUAINPUTS      = ".;$SELFAUTOLOC/lib/{$progname,$engine,}/lua//",

        -- Not really used by MkIV so they might go away.

        BIBINPUTS       = ".;{$TXRESOURCES}//;{$CTXDEVTXPATH};$TEXMF/bibtex/bib//",
        BSTINPUTS       = ".;{$TXRESOURCES}//;{$CTXDEVTXPATH};$TEXMF/bibtex/bst//",

        -- Sort of obsolete.

        OTPINPUTS       = ".;$TEXMF/omega/otp//",
        OCPINPUTS       = ".;$TEXMF/omega/ocp//",

        -- Handy extras. These are normally set in the environment.

        TXRESOURCES     = nil,
        MPRESOURCES     = "$TXRESOURCES",
        MFRESOURCES     = "$MPRESOURCES",

        -- A few special ones that will change some day.

        FONTCONFIG_FILE = "fonts.conf",
        FONTCONFIG_PATH = "$TEXMFOS/fonts/conf",
        FC_CACHEDIR     = "$TEXMFOS/fonts/cache", -- not needed

        -- These variables are available to plug in special local paths, like
        -- the ones used on my machine for development.

        CTXDEVTXPATH    = nil,
        CTXDEVMPPATH    = nil,
        CTXDEVMFPATH    = nil,
        CTXDEVPLPATH    = nil,
        CTXDEVPYPATH    = nil,
        CTXDEVRBPATH    = nil,

        -- Some of the following parameters will disappear. Also, some are
        -- not used at all as we disable the ocp mechanism.

        context         = {

            hash_extra     =  "100000",
            nest_size      =     "500",
            param_size     =   "10000",
            save_size      =   "50000",
            stack_size     =   "10000",
            expand_depth   =   "10000",
            max_print_line =   "10000",
            max_in_open    =     "256",

            ocp_stack_size =   "10000",
            ocp_list_size  =    "1000",

            buf_size       = "4000000", -- obsolete
            ocp_buf_size   =  "500000", -- obsolete

        },

        -- The io modes are similar to the traditional ones. Possible values
        -- are all, paranoid and restricted.

        output_mode  = "restricted",
        input_mode   = "any",

        -- The following variable is under consideration. We do have protection
        -- mechanims but it's not enabled by default.

        command_mode = "any", -- any none list
        command_list = "mtxrun, convert, inkscape, gs, imagemagick, curl, bibtex, pstoedit",

    },

    TEXMFCACHE  = "$SELFAUTOPARENT/texmf-cache", -- for old times sake

}
