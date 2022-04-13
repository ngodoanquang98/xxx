<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class CheckAgeMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        $age = $request->age ?? 0;
        if ($age < 18) {
           // echo 'ban moi co ' . $age . ' tuoi';
            //return response('Bạn chưa đủ 18 tuổi');
            return redirect('/131');
        } 
            echo "ngo doan quang";
        dd($request->is('age'));
        return $next($request);
    }    
     
    /**
     * adsa
     *
     * @param  mixed $next
     * @return void
     */    
    /**
     * adsa
     *
     * @param  mixed $next
     * @return void
     */    
    /**
     * adsa
     *
     * @param  mixed $next
     * @return void
     */
    public function adsa(Closure $next) {
        
    }
}
