INCLUDEPATH += $$PWD
defineTest(qtcAddDeployment) {

MAINPROFILEPWD = $$PWD


win32|win {
    message(PWD = $$PWD)
    message(OUT_PWD = $$OUT_PWD)
    copyCommand =
    for(deploymentfolder, DEPLOYMENTFOLDERS) {
        source = $$MAINPROFILEPWD/$$eval($${deploymentfolder}.source)
        source = $$replace(source, /, \\)
        sourcePathSegments = $$split(source, \\)
        copyPath = $$OUT_PWD/$$eval($${deploymentfolder}.target)
        suffix =
        CONFIG(release, debug|release):suffix=release
        CONFIG(debug, debug|release):suffix=debug
        target = $$copyPath/$$last(sourcePathSegments)
        target = $$replace(target, /, \\)
        target ~= s,\\\\\\.?\\\\,\\,
        target1 = $$copyPath/$$suffix/$$last(sourcePathSegments)
        target1 = $$replace(target1, /, \\)
        target1 ~= s,\\\\\\.?\\\\,\\,
        !isEqual(source,$$target) {
            !isEmpty(copyCommand):copyCommand += &&
            isEqual(QMAKE_DIR_SEP, \\) {
                copyCommand += $(COPY_DIR) \"$$source\" \"$$target\"
                copyCommand += && $(COPY_DIR) \"$$source\" \"$$target1\"
            } else {
                source = $$replace(source, \\\\, /)
                target = $$OUT_PWD/$$eval($${deploymentfolder}.target)
                target = $$replace(target, \\\\, /)
                target1 = $$OUT_PWD/$$eval($${deploymentfolder}.target)
                target1 = $$replace(target1, \\\\, /)
                copyCommand += test -d \"$$target\" || mkdir -p \"$$target\" && cp -r \"$$source\" \"$$target\"
                copyCommand += && test -d \"$$target1\" || mkdir -p \"$$target1\" && cp -r \"$$source\" \"$$target1\"
            }
        }
    }
    !isEmpty(copyCommand) {
        copyCommand = @echo Copying application data... && $$copyCommand
        copydeploymentfolders.commands = $$copyCommand
        first.depends = $(first) copydeploymentfolders
        export(first.depends)
        export(copydeploymentfolders.commands)
        QMAKE_EXTRA_TARGETS += first copydeploymentfolders
    }
} else:unix {
    # Assumed to be a Desktop Unix
    copyCommand =
    for(deploymentfolder, DEPLOYMENTFOLDERS) {
        source = $$MAINPROFILEPWD/$$eval($${deploymentfolder}.source)
        source = $$replace(source, \\\\, /)
        macx {
            target = $$OUT_PWD/$${TARGET}.app/Contents/Resources/$$eval($${deploymentfolder}.target)
        } else {
            target = $$OUT_PWD/$$eval($${deploymentfolder}.target)
        }
        target = $$replace(target, \\\\, /)
        sourcePathSegments = $$split(source, /)
        targetFullPath = $$target/$$last(sourcePathSegments)
        targetFullPath ~= s,/\\.?/,/,
        !isEqual(source,$$targetFullPath) {
            !isEmpty(copyCommand):copyCommand += &&
            copyCommand += $(MKDIR) \"$$target\"
            copyCommand += && $(COPY_DIR) \"$$source\" \"$$target\"
        }
    }
    !isEmpty(copyCommand) {
        copyCommand = @echo Copying application data... && $$copyCommand
        copydeploymentfolders.commands = $$copyCommand
        first.depends = $(first) copydeploymentfolders
        export(first.depends)
        export(copydeploymentfolders.commands)
        QMAKE_EXTRA_TARGETS += first copydeploymentfolders
    }

    !isEmpty(target.path) {
        installPrefix = $${target.path}
    } else {
        installPrefix = /opt/$${TARGET}
    }
    for(deploymentfolder, DEPLOYMENTFOLDERS) {
        item = item$${deploymentfolder}
        itemfiles = $${item}.files
        $$itemfiles = $$eval($${deploymentfolder}.source)
        itempath = $${item}.path
        $$itempath = $${installPrefix}/$$eval($${deploymentfolder}.target)
        export($$itemfiles)
        export($$itempath)
        INSTALLS += $$item
    }

    !isEmpty(desktopfile.path) {
        export(icon.files)
        export(icon.path)
        export(desktopfile.files)
        export(desktopfile.path)
        INSTALLS += icon desktopfile
    }

    isEmpty(target.path) {
        target.path = $${installPrefix}/bin
        export(target.path)
    }
    INSTALLS += target
}

export (ICON)
export (INSTALLS)
export (DEPLOYMENT)
export (LIBS)
export (QMAKE_EXTRA_TARGETS)
}
