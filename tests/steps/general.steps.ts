import { expect } from "@playwright/test";
import { Given } from "../../support/fixtures";

Given ('Has title',
    async ({ page }) => {
        await page.goto('https://playwright.dev/');
        await expect(page).toHaveTitle('Playwright')
    }
)