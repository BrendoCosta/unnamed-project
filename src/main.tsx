import { StrictMode } from "react"
import { createRoot } from "react-dom/client"
import { PrimeReactProvider } from "primereact/api";
import App from "./App.tsx";
import "./index.css";

const options = {
    ripple: true,
};

createRoot(document.getElementById("root")!).render(
    <StrictMode>
        <PrimeReactProvider value={options}>
            <App />
        </PrimeReactProvider>
    </StrictMode>,
)
