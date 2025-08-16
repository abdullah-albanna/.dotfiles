function infwget
    set extra_args --tries=0 --timeout=30 --waitretry=5 --retry-connrefused --continue

    while true
        echo -n "Running: wget"
        for arg in $extra_args $argv
                echo -n " '$arg'"
        end
        echo

        # This runs wget with args correctly even with spaces/quotes
        wget $extra_args $argv

        if test $status -eq 0
            echo "infwget: Download completed successfully."
            break
        else
            echo "infwget: Download failed, retrying in 5 seconds..."
            sleep 5
        end
    end
end
