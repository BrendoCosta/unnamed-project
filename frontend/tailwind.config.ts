import type { Config } from "tailwindcss";
import colors from "tailwindcss/colors";
import tailwindcssMotion from "tailwindcss-motion";

export default
{
    content: [
        "./index.html",
        "./src/**/*.{js,ts,jsx,tsx}",
    ],
    theme: {
        extend: {
            colors: {
                primary: colors.indigo
            }
        },
    },
    plugins: [tailwindcssMotion],
} satisfies Config