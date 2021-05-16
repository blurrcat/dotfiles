function bang
    set BANG $argv[1]
    set QUERY $argv[2..-1]
    switch $BANG
        case yd
            set URL "https://dict.youdao.com/search?le=eng&q=$QUERY"
        case '*'
            set URL "https://duckduckgo.com/?q=!$BANG $QUERY"
    end

    lynx -dump -nolist -force_html "$URL" | less
end
