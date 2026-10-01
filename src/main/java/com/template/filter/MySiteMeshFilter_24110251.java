package com.template.filter;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class MySiteMeshFilter_24110251 extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.addDecoratorPath("/admin/*", "/decorators/admin.jsp")
               .addDecoratorPath("/*", "/decorators/web.jsp")
               .addExcludedPath("/")
               .addExcludedPath("/index.jsp")
               .addExcludedPath("/login*")
               .addExcludedPath("/register*")
               .addExcludedPath("/otp*")
               .addExcludedPath("/logout*")
               .addExcludedPath("/decorators/*")
               .addExcludedPath("/assets/*")
               .addExcludedPath("/css/*")
               .addExcludedPath("/js/*");
    }
}
