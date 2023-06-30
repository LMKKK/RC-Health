import router from "@/router";
import Layout from "@/layout/Layout";

// 注意：这个文件是设置动态路由的
// permissions是一个资源的数组
export function activeRouter() {
    const userStr = sessionStorage.getItem("user")
    if (userStr) {
        const user = JSON.parse(userStr)
        let root = {
            path: '/',
            name: 'Layout',
            component: Layout,
            redirect: "/home",
            children: []
        }
        user.permissions.forEach(p => {
            let obj = {
                path: p.path,
                name: p.name,
                component: () => import("@/views/" + p.name)
            };
            root.children.push(obj)
        })
        if (router) {
            router.addRoute(root)
        }
    }
}


