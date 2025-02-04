import { useState } from "react";
import "./App.css";

export default function App() 
{
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
  
    const handleLogin = (event: React.FormEvent) => {
      event.preventDefault();
      const userData = { email, password };
      console.log(userData);
    };

    return (
        <>
            <div className= "flex items-center justify-center min-h-screen bg-gray-100">
                <div className= "w-full max-w-sm p-6 bg-white rounded-lg shadow-md">
                    <h2 className= "text-2xl font-bold text-center text-gray-700">Login</h2>
                    <form className= "mt-4" onSubmit={handleLogin}>
                        <div>
                            <label className= "block text-sm font-medium text-gray-600">E-mail</label>
                            <input
                                type= "email"
                                className= "w-full px-4 py-2 mt-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                                placeholder= "Digite seu email"
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                                required
                            />
                        </div>
                        <div className= "mt-4">
                        <label className= "block text-sm font-medium text-gray-600">Senha</label>
                            <input
                                type= "password"
                                className= "w-full px-4 py-2 mt-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                                placeholder= "Digite sua senha"
                                value={password}
                                onChange={(e) => setPassword(e.target.value)}
                                required
                            />
                        </div>
                        <button
                            type= "submit"
                            className="w-full px-4 py-2 mt-4 font-bold text-white bg-blue-500 rounded-lg hover:bg-blue-600"
                        >
                          Entrar
                        </button>    
                    </form>
                    <p className= "mt-4 text-sm text-center text-gray600">
                        Não tem uma conta? <a href= "cadastro" className= "text-blue-500 hover:underline">Cadastre-se</a>
                    </p>
                </div>
            </div>
        </>
    )
}

