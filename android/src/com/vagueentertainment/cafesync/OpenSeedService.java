package com.vagueentertainment.cafesync;

import android.content.Context;
import android.content.Intent;
import org.qtproject.qt5.android.bindings.QtService;

public class OpenSeedService extends QtService {
    public static void startOpenSeedService(Context ctx) {
            ctx.startService(new Intent(ctx, OpenSeedService.class));
        }
}
