import { defineConfig } from "@playwright/test";
// import { defineBddConfig } from "playwright-bdd";
// import { existsSync } from 'fs';

// const testDir = defineBddConfig({
//     steps: ['test/*.ts', 'test/support/*.ts'],
//     features: 'features/*.feature',
//     outputDir: 'features'
// });

// function isDockerEnv() {
//     try {
//         return existsSync('./dockerenv')
//     } catch (error) {
//         return false
//     }
// }

// const isDocker = isDockerEnv();

export default defineConfig({
    timeout: 5000,
    testDir: './tests',
    outputDir: 'traces',
    use: {
        video: 'off',
        bypassCSP: true,
        ignoreHTTPSErrors: true,
        browserName: process.env.BROWSER as 'chromium' | 'firefox' || 'chromium',
        // ...(isDocker ? {
        //     connectOptions: {
        //         wsEndpoint: 'ws://browsers:3001',
        //         exposeNetwork: 'http://localhost:9222'
        //     }
        // } : {} ),
        trace: 'retain-on-failure',
    },
    projects: [
        {
            name: 'chromium',
            use: { browserName: 'chromium' }
        },
        {
            name: 'firefox',
            use: { browserName: 'firefox' }
        },
        {
            name: 'webkit',
            use: { browserName: 'webkit' }
        }
    ],
    reporter: [
        ['html', { open: 'never' }],
        ['list'],
        ['json', { outputFile: 'test-results.json', open: 'never' }],
    ],
});